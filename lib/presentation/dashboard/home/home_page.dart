import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_app/resources/bag_brands.dart';
import 'package:watch_app/resources/brands.dart';
import 'package:watch_app/resources/grids/ShoeGrids/adidas_grid.dart';
import 'package:watch_app/resources/grids/ShoeGrids/air_jordhan_grid.dart';
import 'package:watch_app/resources/grids/ShoeGrids/celine_grid.dart';
import 'package:watch_app/resources/grids/ShoeGrids/converse.dart';
import 'package:watch_app/resources/grids/ShoeGrids/dior_grid.dart';
import 'package:watch_app/resources/grids/ShoeGrids/nike_grid.dart';
import 'package:watch_app/resources/grids/ShoeGrids/travisScott_grid.dart';
import 'package:watch_app/resources/wallet_brands.dart';
import 'package:watch_app/utills/color.dart';

import '../../../resources/grids/ShoeGrids/offWhite_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  PageController pageController2 = PageController();
  PageController pageController3 = PageController();
  PageController pageController4 = PageController();
  int index1 = 0;
  int index2 = 0;
  int index3 = 0;
  int index4 = 0;
  bool isPressed = false;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    pageController2.dispose();
    pageController3.dispose();
    pageController4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SizedBox(
            width: Get.width * 0.14,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: themeColor,
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                    ))
                  ],
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
                            borderRadius: index1 == 2
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(
                                    18,
                                  ))
                                : BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: Get.height,
                          child: InkWell(
                            onTap: () {
                              index1 = 2;
                              pageController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Center(
                              child: Text(
                                "Bags",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: index1 == 2
                                        ? Colors.white
                                        : themeColor),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: index1 == 2 ? themeColor : Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(18),
                              bottomLeft: Radius.circular(
                                18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 10),
                            color: Colors.white,
                            borderRadius: index1 == 2
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(
                                    18,
                                  ))
                                : BorderRadius.only(
                                    topRight: index1 == 1
                                        ? const Radius.circular(15)
                                        : const Radius.circular(0),
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              index1 = 1;
                            },
                            child: Center(
                              child: Text(
                                "Wallets",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: index1 == 1
                                        ? Colors.white
                                        : themeColor),
                              ),
                            ),
                          ),
                          height: Get.height,
                          decoration: BoxDecoration(
                              color: index1 == 1 ? themeColor : Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(18),
                                  bottomLeft: Radius.circular(
                                    18,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            color: Colors.white,
                            borderRadius: index1 == 0
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(18),
                                    topLeft: Radius.circular(0))
                                : BorderRadius.only(
                                    topLeft: index1 == 1
                                        ? const Radius.circular(15)
                                        : const Radius.circular(0),
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              index1 = 0;
                            },
                            child: Center(
                              child: Text(
                                "Shoes",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: index1 == 0
                                        ? Colors.white
                                        : themeColor),
                              ),
                            ),
                          ),
                          height: Get.height,
                          decoration: BoxDecoration(
                            color: index1 == 0 ? themeColor : Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(18),
                              bottomLeft: Radius.circular(
                                18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              color: Colors.white,
                              borderRadius: index1 == 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(
                                      18,
                                    ))
                                  : BorderRadius.circular(0)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.044,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: Get.height * 0.71,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    children: [
                      Brands(
                        index: index2,
                        pageController: pageController2,
                        adidas: const Adidas(),
                        nike: const Nike(),
                        airJordhan: const AirJordhan(),
                        celine: const CelineSneakers(),
                        dior: const DiorSneakers(),
                        offWhite: const Offwhite(),
                        travis: const TravisScott(),
                        converse: const Converse(),
                      ),
                      const WalletBrand(),
                      const BagBrand(),
                    ],
                    onPageChanged: (value) {
                      setState(() {
                        index1 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
