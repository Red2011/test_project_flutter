import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../models/order.dart';

class TrueOrder extends StatefulWidget {
  final Order order;
  const TrueOrder({super.key, required this.order});

  @override
  State<TrueOrder> createState() => _TrueOrderState(order: order);
}

class _TrueOrderState extends State<TrueOrder> {
  final Order order;
  _TrueOrderState({required this.order});

  double myFigmaWidth = 375;
  double myFigmaHeight = 812;
  double thisWidth = 0;
  double thisHeight = 0;



  @override
  void initState() {
    super.initState();
  }

  bool _installationCompleted = true;
  bool _signedact = false;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    thisWidth = MediaQuery.of(context).size.width / myFigmaWidth;
    thisHeight = MediaQuery.of(context).size.height / myFigmaHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildTrueOrderAppBar(),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20*thisWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: order.descriptions.map((description) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5 * thisHeight),
                      child: Text(
                        description.name,
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14 * thisWidth,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    );
                  }).toList(),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _installationCompleted = !_installationCompleted;
                    });
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)
                        )
                    ),
                    overlayColor: WidgetStateProperty.all(const Color.fromRGBO(98, 146, 241, 0.15)),
                    side: WidgetStateProperty.all(
                        const BorderSide(
                            color: Color.fromRGBO(238, 238, 238, 1),
                            width: 1,
                        )
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15 * thisWidth),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "1",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(98, 146, 241, 1),
                                    fontSize: 16 * thisWidth,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 5 * thisWidth)),
                                Text(
                                  "Установка выполнена",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * thisWidth,
                                  ),
                                ),
                              ],
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: _installationCompleted
                                  ? const Color.fromRGBO(98, 146, 241, 1)
                                  : Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: _installationCompleted
                                      ? Border.all(color: Colors.transparent, width: 0)
                                      : Border.all(
                                      color: const Color.fromRGBO(204, 204, 204, 1),
                                      width: 1
                                  )
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: Checkbox(
                                  visualDensity: VisualDensity.comfortable,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  activeColor: Colors.transparent,
                                  checkColor: Colors.white,
                                  side: BorderSide.none,
                                  value: _installationCompleted,
                                  onChanged: (state) {
                                    setState(() {
                                      _installationCompleted = state!;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(4 * thisWidth)),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _signedact = !_signedact;
                    });
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                        )
                    ),
                    overlayColor: WidgetStateProperty.all(const Color.fromRGBO(98, 146, 241, 0.15)),
                    side: WidgetStateProperty.all(
                        const BorderSide(
                          color: Color.fromRGBO(238, 238, 238, 1),
                          width: 1,
                        )
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15 * thisWidth),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "2",
                                  style: TextStyle(
                                      color: const Color.fromRGBO(98, 146, 241, 1),
                                      fontSize: 16 * thisWidth,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 5*thisWidth)),
                                Text(
                                  "Акт подписан",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15 * thisWidth,
                                  ),
                                ),
                              ],
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: _signedact
                                      ? const Color.fromRGBO(98, 146, 241, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: _signedact
                                      ? Border.all(color: Colors.transparent, width: 0)
                                      : Border.all(
                                      color: const Color.fromRGBO(204, 204, 204, 1),
                                      width: 1
                                  )
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: Checkbox(
                                  visualDensity: VisualDensity.comfortable,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  activeColor: Colors.transparent,
                                  checkColor: Colors.white,
                                  side: BorderSide.none,
                                  value: _signedact,
                                  onChanged: (state) {
                                    setState(() {
                                      _signedact = state!;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10 * thisWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Фото установки"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4 * thisWidth),
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                    overlayColor: WidgetStateProperty.all(const Color.fromRGBO(98, 146, 241, 0.15)),
                                    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
                                    side: WidgetStateProperty.all(const BorderSide(
                                      color: Color.fromRGBO(98, 146, 241, 1),
                                      width: 1
                                    ))
                                  ),
                                  onPressed: () async => _pickImageFromCamera(),
                                  child: const Text(
                                    "Сделать фото",
                                    style: TextStyle(
                                        color: Color.fromRGBO(98, 146, 241, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4 * thisWidth),
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                      overlayColor: WidgetStateProperty.all(const Color.fromRGBO(98, 146, 241, 0.15)),
                                      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
                                      side: WidgetStateProperty.all(const BorderSide(
                                          color: Color.fromRGBO(98, 146, 241, 1),
                                          width: 1
                                      ))
                                  ),
                                  onPressed: () async => _pickImageFromGallery,
                                  child: const Text(
                                    "Добавить фото",
                                    style: TextStyle(
                                        color: Color.fromRGBO(98, 146, 241, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10 * thisWidth),
                        child: Center(
                          child: _imageFile == null ? Container() : SizedBox(
                              width: 300,
                              height: 300,
                              child: Image.file(_imageFile!),
                            ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10 * thisHeight),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(const Color.fromRGBO(98, 146, 241, 1))
                      ),
                      onPressed: ()=>{Navigator.pushNamed(context, '/')},
                      child: const Text(
                        "Подтвердить",
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
          )
        ],
      ),
    );
  }



  AppBar _buildTrueOrderAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      titleSpacing: 2 * thisWidth,
      toolbarHeight: 60 * thisHeight,
      backgroundColor: Colors.white,
      title: Text(
        "Заявка выполнена",
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

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

}