import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/providers/cart_provider.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/storage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String totalPrice = "0";
  num price = 0;
  late List test;

  @override
  void initState() {
    super.initState();
    if (GetStorage().read("myCart") != null) {
      test = GetStorage().read("myCart");
      debugPrint("cart list : $test");
    } else {
      test = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCart>(context);

    return Scaffold(
      body: !Storage.isUserLogin
          ? Center(
              child: AppButton(
                text: "Login",
                width: Get.width / 3,
                onPressed: () {
                  Get.offAllNamed(AppRoutes.loginScreen);
                },
              ),
            )
          : test.isEmpty
              // ? Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       // Image.asset(ImageConstant.emptycart),
              //
              //     ],
              //   )
              ? const Center(child: Text("Your cart is empty"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView.builder(
                    itemCount: test.length,
                    itemBuilder: (context, index) {
                      String price = test[index]["product_price"];
                      double p = double.parse(price);
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Get.height * .02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(Get.height * .01),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * .11,
                                width: Get.width * .23,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Get.width*.02),
                                  child: Image.network(
                                    test[index]["image"].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              wSizedBox6,
                              SizedBox(
                                width: Get.width * .45,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    test[index]["size"] != ""
                                        ? RichText(
                                            text: TextSpan(
                                              text:
                                                  "${test[index]["product_name"]}, ",
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              children: [
                                                const TextSpan(
                                                  text: "Size: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: test[index]["productSize"],
                                                ),
                                              ],
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            test[index]["product_name"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    FittedBox(
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            " \$${p * test[index]["product_qty"]}    ",
                                            style: TextStyle(
                                              color: themeColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Get.height * .025,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      test[index]["product_qty"] ==
                                                              1
                                                          ? null
                                                          : test[index][
                                                                      "product_qty"] >=
                                                                  1
                                                              ? test[index]
                                                                  ["product_qty"]--
                                                              : null;
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  size: Get.height * .04,
                                                ),
                                              ),
                                              Text(
                                                " ${test[index]["product_qty"]} ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Get.height * .025,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    test[index]["product_qty"]++;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.add_circle,
                                                  size: Get.height * .04,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Align(
                                child: IconButton(
                                    onPressed: () {
                                      debugPrint(
                                          "id is : ${test[index]["product_id"]}");
                                      provider.removeFromCart(
                                          test[index]["product_id"]);
                                    },
                                    icon: const Icon(Icons.delete_forever)),
                              ),
                            ],
                          ),
                        ),
                      );
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              test[index]["image"].toString(),
                            ),
                          ),
                          title: Text(test[index]["name"]),
                        ),
                      );
                    },
                  ),
                ),
      bottomNavigationBar: test.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Total amout - "),
                        Text("${provider.totalPrice()} \$"),
                      ],
                    ),
                  ),
                  AppButton(
                    text: "Proceed",
                    width: Get.width / 1.3,
                    color: themeColor,
                    onPressed: () {
                      Get.toNamed(AppRoutes.orderSummaryScreen);
                    },
                  ),
                  hSizedBox6,
                ],
              ),
            ),
    );
  }
}
