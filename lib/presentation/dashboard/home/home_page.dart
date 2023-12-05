import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/models/product_tile.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_controller.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/brand_button.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/empty_product.dart';
import 'package:watch_app/utills/loader.dart';
import 'package:watch_app/utills/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int index1 = 0;
  // int index2 = 0;
  // int index3 = 0;
  // int index4 = 0;
  // bool isPressed = false;
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Row(
  //       children: [
  //         SizedBox(
  //           width: Get.width * 0.14,
  //           child: Stack(
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                       child: Container(
  //                     color: themeColor,
  //                   )),
  //                   Expanded(
  //                       child: Container(
  //                     color: Colors.white,
  //                   ))
  //                 ],
  //               ),
  //               RotatedBox(
  //                 quarterTurns: 3,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Expanded(
  //                       flex: 4,
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.white),
  //                           color: Colors.white,
  //                           borderRadius: index1 == 2
  //                               ? const BorderRadius.only(
  //                                   topRight: Radius.circular(
  //                                   18,
  //                                 ))
  //                               : BorderRadius.circular(0),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 3,
  //                       child: Container(
  //                         height: Get.height,
  //                         decoration: BoxDecoration(
  //                           color: index1 == 2 ? themeColor : Colors.white,
  //                           borderRadius: const BorderRadius.only(
  //                             bottomRight: Radius.circular(18),
  //                             bottomLeft: Radius.circular(
  //                               18,
  //                             ),
  //                           ),
  //                         ),
  //                         child: InkWell(
  //                           onTap: () {
  //                             index1 = 2;
  //                           },
  //                           child: Center(
  //                             child: Text(
  //                               "Accessories",
  //                               style: TextStyle(
  //                                   fontSize: 15,
  //                                   color: index1 == 2
  //                                       ? Colors.white
  //                                       : themeColor),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.white, width: 10),
  //                           color: Colors.white,
  //                           borderRadius: index1 == 2
  //                               ? const BorderRadius.only(
  //                                   topLeft: Radius.circular(
  //                                   18,
  //                                 ))
  //                               : BorderRadius.only(
  //                                   topRight: index1 == 1
  //                                       ? const Radius.circular(15)
  //                                       : const Radius.circular(0),
  //                                 ),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 3,
  //                       child: Container(
  //                         height: Get.height,
  //                         decoration: BoxDecoration(
  //                             color: index1 == 1 ? themeColor : Colors.white,
  //                             borderRadius: const BorderRadius.only(
  //                                 bottomRight: Radius.circular(18),
  //                                 bottomLeft: Radius.circular(
  //                                   18,
  //                                 ))),
  //                         child: InkWell(
  //                           onTap: () {
  //
  //                             index1 = 1;
  //                           },
  //                           child: Center(
  //                             child: Text(
  //                               "Wallets",
  //                               style: TextStyle(
  //                                   fontSize: 15,
  //                                   color: index1 == 1
  //                                       ? Colors.white
  //                                       : themeColor),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.white, width: 5),
  //                           color: Colors.white,
  //                           borderRadius: index1 == 0
  //                               ? const BorderRadius.only(
  //                                   topRight: Radius.circular(18),
  //                                   topLeft: Radius.circular(0))
  //                               : BorderRadius.only(
  //                                   topLeft: index1 == 1
  //                                       ? const Radius.circular(15)
  //                                       : const Radius.circular(0),
  //                                 ),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 3,
  //                       child: Container(
  //                         height: Get.height,
  //                         decoration: BoxDecoration(
  //                           color: index1 == 0 ? themeColor : Colors.white,
  //                           borderRadius: const BorderRadius.only(
  //                             bottomRight: Radius.circular(18),
  //                             bottomLeft: Radius.circular(
  //                               18,
  //                             ),
  //                           ),
  //                         ),
  //                         child: InkWell(
  //                           onTap: () {
  //
  //                             index1 = 0;
  //                           },
  //                           child: Center(
  //                             child: Text(
  //                               "Bags",
  //                               style: TextStyle(
  //                                   fontSize: 15,
  //                                   color: index1 == 0
  //                                       ? Colors.white
  //                                       : themeColor),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 4,
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                             border: Border.all(color: Colors.white, width: 5),
  //                             color: Colors.white,
  //                             borderRadius: index1 == 0
  //                                 ? const BorderRadius.only(
  //                                     topLeft: Radius.circular(
  //                                     18,
  //                                   ))
  //                                 : BorderRadius.circular(0)),
  //                       ),
  //                     ),
  //                     // Expanded(
  //                     //   child: Container(
  //                     //     decoration: BoxDecoration(
  //                     //       border: Border.all(color: Colors.white, width: 5),
  //                     //       color: Colors.white,
  //                     //       borderRadius: index1 == 0
  //                     //           ? const BorderRadius.only(
  //                     //           topRight: Radius.circular(18),
  //                     //           topLeft: Radius.circular(0))
  //                     //           : BorderRadius.only(
  //                     //         topLeft: index1 == 1
  //                     //             ? const Radius.circular(15)
  //                     //             : const Radius.circular(0),
  //                     //       ),
  //                     //     ),
  //                     //   ),
  //                     // ),
  //                     // Expanded(
  //                     //   flex: 3,
  //                     //   child: Container(
  //                     //     height: Get.height,
  //                     //     decoration: BoxDecoration(
  //                     //       color: index1 == 0 ? themeColor : Colors.white,
  //                     //       borderRadius: const BorderRadius.only(
  //                     //         bottomRight: Radius.circular(18),
  //                     //         bottomLeft: Radius.circular(
  //                     //           18,
  //                     //         ),
  //                     //       ),
  //                     //     ),
  //                     //     child: InkWell(
  //                     //       onTap: () {
  //                     //
  //                     //         index1 = 0;
  //                     //       },
  //                     //       child: Center(
  //                     //         child: Text(
  //                     //           "Sneakers",
  //                     //           style: TextStyle(
  //                     //               fontSize: 20,
  //                     //               color: index1 == 0
  //                     //                   ? Colors.white
  //                     //                   : themeColor),
  //                     //         ),
  //                     //       ),
  //                     //     ),
  //                     //   ),
  //                     // ),
  //                     // Expanded(
  //                     //   flex: 4,
  //                     //   child: Container(
  //                     //     decoration: BoxDecoration(
  //                     //         border: Border.all(color: Colors.white, width: 5),
  //                     //         color: Colors.white,
  //                     //         borderRadius: index1 == 0
  //                     //             ? const BorderRadius.only(
  //                     //             topLeft: Radius.circular(
  //                     //               18,
  //                     //             ))
  //                     //             : BorderRadius.circular(0)),
  //                     //   ),
  //                     // ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: Get.height * 0.044,
  //               ),
  //               const Text("data"),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  List<String> leftSideItems = ["sneakers", "Bags", "Wallets", "Accessories"];
  List<String> topSideItems = ["New Releases", "Best Seller", "Recommended"];

  final BottomBarController _bottomBarController =
      Get.put(BottomBarController());

  final ScrollController _scrollController = ScrollController();

  notifyScroll() {
    debugPrint("scroll hit request.........");
    if (_bottomBarController.isLoading.value) {
      return;
    } else {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print("________scroll testing");
        _bottomBarController.trueAndIncrement();
        if (_bottomBarController.selectedTopItem.value != -1) {
          _bottomBarController.getTopItemProducts(
            context,
            url: _bottomBarController.selectedTopItem.value == 0
                ? getnewReleaseProductsApi
                : _bottomBarController.selectedTopItem.value == 1
                    ? getBestSellerProductsApi
                    : getRecommendedProductsApi,
          );
        } else if (_bottomBarController.selectedLeftitem.value != -1) {
          _bottomBarController.getLeftItemProducts(context,
              categoryId: _bottomBarController.categoryId.value);
        } else {
          _bottomBarController.getProductsByBrands(
            context,
            brandId: _bottomBarController.brandId.value,
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      notifyScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavoProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: Get.height * .05),
        height: Get.height,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * .17,
              padding: EdgeInsets.only(top: Get.height * .1),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: leftSideItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _bottomBarController.selectedTopItem.value = -1;
                          _bottomBarController.selectedLeftitem.value = index;
                          _bottomBarController.categoryId.value = index == 0
                              ? "200"
                              : index == 1
                                  ? "204"
                                  : index == 2
                                      ? "203"
                                      : "3029";
                        });

                        _bottomBarController.getProducts(
                          context,
                          selectedOption: GetProductsBy.leftItems,
                          categoryId: index == 0
                              ? "200"
                              : index == 1
                                  ? "204"
                                  : index == 2
                                      ? "203"
                                      : "3029",
                        );
                      },
                      child: Obx(
                        () => RotatedBox(
                          quarterTurns: 1,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  _bottomBarController.selectedLeftitem.value ==
                                          index
                                      ? themeColor
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              leftSideItems[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: _bottomBarController
                                            .selectedLeftitem.value ==
                                        index
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: Get.height * .05,
                  width: Get.width * .80,
                  child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: topSideItems.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => BrandButton(
                            index: index,
                            onpressed: () {
                              setState(() {
                                _bottomBarController.selectedLeftitem.value =
                                    -1;
                                _bottomBarController.selectedTopItem.value =
                                    index;
                              });
                              _bottomBarController.getProducts(
                                context,
                                selectedOption: index == 0
                                    ? GetProductsBy.newRelease
                                    : index == 1
                                        ? GetProductsBy.bestSelleer
                                        : GetProductsBy.recommended,
                              );
                            },
                            title: topSideItems[index],
                            iNo: _bottomBarController.selectedTopItem.value,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return wSizedBox8;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: Get.height * .644,
                    width: Get.width * .80,
                    child: _bottomBarController.productsFetch.value == true
                        ? _bottomBarController.products.isNotEmpty
                            ? Obx(
                                () => GridView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    top: Get.height * .015,
                                    right: Get.width * .05,
                                  ),
                                  itemCount:
                                      _bottomBarController.products.length + 1,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        100 / 160, // getHeight() * .0013,
                                    // mainAxisExtent: getHeight()*.24,
                                    //     getWidth() / (getHeight() / 1.80),
                                    // mainAxisExtent: getHeight() * .235,
                                  ),
                                  itemBuilder: (context, index) {
                                    return index <
                                            _bottomBarController.products.length
                                        ? ProductTile(
                                            imageUrl: _bottomBarController
                                                    .products[index]
                                                    .productImg ??
                                                "",
                                            name: _bottomBarController
                                                    .products[index].title ??
                                                "",
                                            price: _bottomBarController
                                                .products[index].price
                                                .toString(),
                                            isFavourite:
                                                favouriteProvider.isFavourite(
                                                    _bottomBarController
                                                            .products[index]
                                                            .title ??
                                                        ""),
                                            onIconTap: () {
                                              if (Storage.isUserLogin) {
                                                favouriteProvider.favorite(
                                                  _bottomBarController
                                                          .products[index]
                                                          .title ??
                                                      "",
                                                  _bottomBarController
                                                      .products[index].price
                                                      .toString(),
                                                  _bottomBarController
                                                          .products[index]
                                                          .productImg ??
                                                      "",
                                                  _bottomBarController
                                                      .products[index].productId
                                                      .toString(),
                                                );
                                              } else {
                                                customDialogue(
                                                  message:
                                                      "Please login to add products to favourite",
                                                );
                                              }
                                            },
                                            onProductTap: () {
                                              debugPrint(
                                                  "Product id is : ${_bottomBarController.products[index].productId}");
                                              Get.to(
                                                () => ProductDetail(
                                                  id: _bottomBarController
                                                      .products[index].productId
                                                      .toString(),
                                                ),
                                              );
                                            },
                                            // _bottomBarController
                                            //         .products[index].title ??
                                            //     "",
                                          )
                                        :
                                        // _bottomBarController.isLoading.value
                                        //         ?
                                        Loader.apiLoading();
                                    // : const SizedBox.shrink();
                                  },
                                ),
                              )
                            : EmptyProduct()
                        : Loader.apiLoading(),
                    // child:const EmptyProduct(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
