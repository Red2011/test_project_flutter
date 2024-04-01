import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/components/true_icons_icons.dart';
import 'package:test_project/models/order.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_project/pages/order/true_order.dart';


class OrderInfoPage extends StatefulWidget {
  final Order order;
  OrderInfoPage({required this.order});

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState(order: order);
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  final Order order;
  _OrderInfoPageState({required this.order});

  double myFigmaWidth = 375;
  double myFigmaHeight = 812;
  double thisWidth = 0;
  double thisHeight = 0;
  final _controller = TextEditingController();

  //final ScrollController _scrollController = ScrollController();



  // void _scrollToTextField() {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeIn,
  //     );
  //
  // }



  @override
  void initState() {
    super.initState();
  }

   String _inputText = "";

  @override
  Widget build(BuildContext context) {
    thisWidth = MediaQuery.of(context).size.width / myFigmaWidth;
    thisHeight = MediaQuery.of(context).size.height / myFigmaHeight;


    Color descriptionColor(bool state) => state ? Colors.black : const Color.fromRGBO(199, 0, 0, 1);
    String payment = order.payment ? "Оплачено" : "Не оплачено";


    return Scaffold(
      appBar: _buildOrderAppBar(),
      body: ListView(
        //controller: _scrollController,
        children: [Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20*thisWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200 * thisWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: order.descriptions.map((description) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 3 * thisHeight),
                      child: Text(
                        description.name,
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14 * thisWidth,
                          fontWeight: FontWeight.w400,
                          color: descriptionColor(description.state)
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: orderInfo("Код склада", order.code)),
                          Expanded(flex: 3, child: orderInfo("Номер заказа", order.order_num)),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: orderInfo("Товарный номер", order.product_number)),
                          Expanded(flex: 2, child: orderInfo("Оплата", payment)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(16* thisWidth),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color.fromRGBO(98, 146, 241, 1),
                    width: 1
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5*thisHeight),
                      child: const Text(
                        "Клиент",
                        style: TextStyle(
                          color: Color.fromRGBO(98, 146, 241, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        ),
                      ),
                    ),
                    clientInfo(const Icon(TrueIcons.user, size: 24), order.client.name),
                    clientInfo(const Icon(Icons.location_on_outlined, size: 24), order.client.addr),
                    clientInfo(const Icon(Icons.phone_outlined, size: 24), order.client.tel),
                    clientInfo(SvgPicture.asset('assets/otsiv.svg', width: 24,), order.client.message),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5 * thisHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Сообщение менеджеру",
                      style: TextStyle(
                        color: const Color.fromRGBO(31, 39, 111, 1),
                        fontFamily: GoogleFonts.firaSans().fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                      ),
                    ),Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        //onTap: _scrollToTextField,
                        onChanged: (String text) {
                          setState(() {
                            _inputText = text;
                          });
                        },
                        textAlign: TextAlign.start,
                        controller: _controller,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Color.fromRGBO(8, 146, 241, 1),
                          decoration: TextDecoration.none,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Введите сообщение',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(8, 146, 241, 1)
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(98, 146, 241, 1),
                              width: 1
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          fillColor: Color.fromRGBO(245, 250, 255, 1),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10 * thisHeight, bottom: 60 * thisHeight),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(98, 146, 241, 1))
                    ),
                    onPressed: ()=>{
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TrueOrder(order: order))
                      )
                    },
                    child: const Text(
                      "Выполнить",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                      ),
                    )
                ),
              )
            ],
          ),
        ),]
      )
    );
  }

  AppBar _buildOrderAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      titleSpacing: 2 * thisWidth,
      toolbarHeight: 60 * thisHeight,
      backgroundColor: Colors.white,
      title: Text(
        "Информация по заявке",
        style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 22 * thisWidth),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined), // Иконка, которую нужно изменить
        onPressed: () {
          // Действие при нажатии на кнопку "Назад"
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Container orderInfo(String name, String orderName) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5*thisWidth, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromRGBO(245, 250, 255, 1)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Color.fromRGBO(98, 146, 241, 1)
            ),
          ),
          Text(orderName)
        ],
      ),
    );
  }

  Widget clientInfo(dynamic icon, String info) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7*thisHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13*thisWidth),
              child: Text(
                info,
                softWrap: true,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}




