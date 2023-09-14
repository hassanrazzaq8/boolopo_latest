import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/presentation/auth/login/login_screen.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_screen.dart';
import 'package:watch_app/providers/cart_provider.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/snack_bar.dart';

import '../../../models/cart_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.id,
  }) : super(key: key);
  final String image;
  final String name;
  final String price;
  final int id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  int size = 0;
  bool isRated = false;
  TextEditingController sizeController = TextEditingController();
  final double count = 1;
  var x;
  @override
  void initState() {
    super.initState();
    x = GetStorage().read("isIt");
  }

  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCart>(context);

    Widget rate(bool state) {
      return InkWell(
        onTap: () {},
        child: state
            ? const Icon(
                Icons.star,
                color: Colors.grey,
              )
            : const Icon(
                Icons.star_border,
                color: Colors.grey,
              ),
      );
    }

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "BOO--LOPO",
            style: GoogleFonts.oswald(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                scaffoldkey.currentState!.openDrawer();
              },
              icon: Image.asset(ImageConstant.menu),
              iconSize: 20,
            ),
          ],
        ),
        drawer: BottomBarScreen().drawerOpen(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey.shade800,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    minimumSize: const Size(150, 50)),
                onPressed: () {
                  if (x != null) {
                    provider.addToCart(
                      widget.id,
                      widget.name,
                      widget.price,
                      count,
                      widget.image,
                    );
                    showSnackBar("Product added to your cart", context);
                    Navigator.pop(context);
                  } else {
                    Get.offAllNamed(AppRoutes.loginScreen);
                  }
                },
                child: const Text("Add To Cart"),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.name,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // color: const Color.fromARGB(248, 9, 34, 90).withOpacity(.40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .40,
                        width: double.infinity,
                        child: Align(
                          child: Image.network(
                            widget.image,
                            height: size == 1
                                ? MediaQuery.of(context).size.height * .25
                                : size == 2
                                    ? MediaQuery.of(context).size.height * .30
                                    : size == 3
                                        ? MediaQuery.of(context).size.height *
                                            .35
                                        : size == 4
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .38
                                            : size == 5
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .40
                                                : MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                " \$ ${widget.price}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                "price",
                                style: GoogleFonts.robotoMono(
                                  // fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  rate(false),
                                  rate(false),
                                  rate(false),
                                  rate(false),
                                  rate(false),
                                ],
                              ),
                              Text(
                                " Rating",
                                style: GoogleFonts.robotoMono(
                                  // fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 2,
                          height: 10,
                          color: const Color.fromARGB(248, 9, 34, 90),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              size = 1;
                            });
                          },
                          child: size == 1
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    child: Text(
                                      "41",
                                      style: GoogleFonts.roboto(
                                        fontSize: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "41",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                        )
                      ],
                    ),
                    // Stack(
                    //   children: [
                    //     Image.network(
                    //       "https://www.pngkey.com/png/full/896-8964716_line-curve-png.png",
                    //       color: Colors.green,
                    //       height: 50,
                    //       width: 50,
                    //     ),
                    //     Text(
                    //       "41",
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 20,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     Text(
                    //       "size",
                    //       style: GoogleFonts.roboto(
                    //         // fontSize: 20,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      children: [
                        Container(
                          width: 2,
                          height: 10,
                          color: const Color.fromARGB(248, 9, 34, 90),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              size = 2;
                            });
                          },
                          child: size == 2
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    child: Text(
                                      "42",
                                      style: GoogleFonts.roboto(
                                        fontSize: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "42",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 2,
                          height: 10,
                          color: const Color.fromARGB(248, 9, 34, 90),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              size = 3;
                            });
                          },
                          child: size == 3
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    child: Text(
                                      "43",
                                      style: GoogleFonts.roboto(
                                        fontSize: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "43",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 2,
                          height: 10,
                          color: const Color.fromARGB(248, 9, 34, 90),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              size = 4;
                            });
                          },
                          child: size == 4
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    child: Text(
                                      "44",
                                      style: GoogleFonts.roboto(
                                        fontSize: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "44",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 2,
                          height: 10,
                          color: const Color.fromARGB(248, 9, 34, 90),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              size = 5;
                            });
                          },
                          child: size == 5
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    child: Text(
                                      "45",
                                      style: GoogleFonts.roboto(
                                        fontSize: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "45",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("COULDN'T FIND YOUR SIZE?"),
                ),
                const SizedBox(
                  height: 2,
                ),
                TextField(
                    controller: sizeController,
                    decoration: const InputDecoration(
                      hintText: "Write your size here in US or EUR",
                      border: OutlineInputBorder(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
