import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/components/true_icons_icons.dart';
import 'package:test_project/controllers/controller.dart';
import 'package:test_project/models/order.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_project/pages/order/order_info_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends StateMVC {
  double myFigmaWidth = 375;
  double myFigmaHeight = 812;
  double thisWidth = 0;
  double thisHeight = 0;
  OrderController? _controller;

  _MainPageState() : super(OrderController()) {
    _controller = controller as OrderController;
  }

  @override
  void initState() {
    super.initState();
    _controller?.init();
  }

  int _currentTabIndex = 1;



  @override
  Widget build(BuildContext context) {
    thisWidth = MediaQuery.of(context).size.width / myFigmaWidth;
    thisHeight = MediaQuery.of(context).size.height / myFigmaHeight;

    final _tabIndex = <Widget>[
      const Center(child: Text("1")),
      _main(),
      const Center(child: Text("3"))
    ];

    final _BottomBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(TrueIcons.star), label: ''),
      const BottomNavigationBarItem(
          icon: Icon(TrueIcons.menu_outline), label: ''),
      const BottomNavigationBarItem(icon: Icon(TrueIcons.user), label: '')
    ];
    assert(_tabIndex.length == _BottomBarItems.length);

    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: const Color.fromRGBO(98, 146, 241, 0.3),
            highlightColor: const Color.fromRGBO(98, 146, 241, 0.3)),
        child: BottomNavigationBar(
          iconSize: 30 * thisWidth,
          selectedItemColor: const Color.fromRGBO(98, 146, 241, 1),
          unselectedItemColor: const Color.fromRGBO(98, 146, 241, 1),
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: _BottomBarItems,
          currentIndex: _currentTabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
        ),
      ),
      body: _tabIndex[_currentTabIndex],
    );
  }

  Widget _main() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildMainAppBar(),
      body: _buildMainContent()
    );
  }


  Widget _buildMainContent() {
    final state = _controller?.currentState;
    if (state is OrderResultLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(98, 146, 241, 1),
        backgroundColor: Colors.transparent,
      ));
    } else if (state is OrderResultFailure) {
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      final orders = (state as OrderResultSuccess).orderList.orders;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10*thisWidth, vertical: 0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(10 * thisWidth),
                child: _buildOrderItem(orders[index]));
          },
        ),
      );
    }
  }

  AppBar _buildMainAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      titleSpacing: 25 * thisWidth,
      toolbarHeight: 60 * thisHeight,
      backgroundColor: Colors.white,
      title: Text(
        "Заявки",
        style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 26 * thisWidth),
      ),
    );
  }

  Widget _buildOrderItem(Order order) {
    var dateColor = const Color.fromRGBO(55, 139, 96, 1);
    var borderColor = Colors.white;
    var borderWidth = 0.01;
    var orderBorder = Border.all(
      width: 1,
      color: const Color.fromRGBO(238, 238, 238, 1)
    );
    if (order.state) {
      borderWidth = 3;
      borderColor = const Color.fromRGBO(199, 0, 0, 1);
      dateColor = const Color.fromRGBO(199, 0, 0, 1);
      orderBorder = Border(
        left: BorderSide(
          color: borderColor,
          width: borderWidth
        )
      );
    }
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderInfoPage(order: order))
        )
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10 * thisHeight, horizontal: 20 * thisWidth),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [BoxShadow(
              color: Color.fromRGBO(37, 187, 197, 0.1),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.09),
                  blurRadius: 9.9,
                  offset: Offset(1, -1)
              )
            ],
            border: orderBorder
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Visibility(
                  visible: order.state,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16*thisWidth, vertical: 5*thisHeight),
                    decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(31, 39, 111, 1)
                        ),
                    child: const Text(
                      "Доработать",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10 * thisHeight),
              child: Text(
                order.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/routing.svg',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13 * thisHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: order.adresses.map((address) {
                      return Text(address.name);
                    }).toList(),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10 * thisHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_outlined, color: dateColor,),
                      Padding(padding: EdgeInsets.all(3 * thisWidth)),
                      Text(
                          order.date,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: dateColor
                          ),
                      )
                    ],
                  ),
                  Text(
                      "${order.price} ₽",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
