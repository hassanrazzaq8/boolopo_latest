import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/models/product_tile.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/presentation/commamn/serach_box.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
import 'package:watch_app/presentation/dashboard/search/search_controller.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/empty_product.dart';
import 'package:watch_app/utills/loader.dart';
import 'package:watch_app/utills/storage.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchScreenController _con = Get.put(SearchScreenController());

  Timer? addValueStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(
      milliseconds: 2000,
    );

    if (addValueStoppedTyping != null) {
      setState(() => addValueStoppedTyping!.cancel()); // clear timer
    }

    setState(
      () => addValueStoppedTyping = Timer(duration, () {
        _con.searchProduct(value);
      }),
    );
  }



  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavoProvider>(context);
    return Scaffold(
      appBar: appBar(
        text: AppString.srch,
        back: true,
        actionIcon: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        child: Column(
          children: [
            searchBox(
              hint: AppString.search,
              onChange: (value) {
                _onChangeHandler(value);
                if(value==null){
                  _con.searchProduct("");
                }
              },
            ),
            hSizedBox10,
            Obx(
              () => Expanded(
                child: _con.productSearched.value == true
                    ? _con.searchedProducts.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: Get.height * .015,
                              right: Get.width * .05,
                            ),
                            itemCount: _con.searchedProducts.length,
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
                              return ProductTile(
                                imageUrl:
                                    _con.searchedProducts[index].productImg ??
                                        "",
                                name: _con.searchedProducts[index].title ?? "",
                                price: _con.searchedProducts[index].price
                                    .toString(),
                                isFavourite: favouriteProvider.isFavourite(
                                    _con.searchedProducts[index].title ?? ""),
                                onIconTap: () {
                                  if (Storage.isUserLogin) {
                                    favouriteProvider.favorite(
                                      _con.searchedProducts[index].title ?? "",
                                      _con.searchedProducts[index].price
                                          .toString(),
                                      _con.searchedProducts[index].productImg ??
                                          "",
                                      _con.searchedProducts[index].productId
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
                                      "Product id is : ${_con.searchedProducts[index].productId}");
                                  Get.to(
                                    () => ProductDetail(
                                      id: _con.searchedProducts[index].productId
                                          .toString(),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : Icon(
                            Icons.search_off,
                            size: Get.height * .1,
                          )
                    : Loader.apiLoading(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
