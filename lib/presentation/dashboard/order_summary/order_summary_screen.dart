import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/presentation/payment/payment_screen.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/loader.dart';

import 'order_summary_controller.dart';

class OrderSummaryScreen extends StatefulWidget {
  OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  final OrderSummaryController _con = Get.put(OrderSummaryController());
  List storeAddresses = [];
  List cartItems = [];

  @override
  void initState() {
    super.initState();
    if (GetStorage().read(AppString.address) != null) {
      storeAddresses = GetStorage().read(AppString.address);
    } else {
      storeAddresses = [];
    }
    cartItems = GetStorage().read("mycart") ?? [];
    debugPrint("store addresses $storeAddresses");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: AppString.orderSummary,
        back: true,
        actionIcon: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        width: Get.width / 2,
        text: AppString.payment,
        onPressed: () async {
          // if (storeAddresses.isEmpty) {
          //   customDialogue(
          //       message:
          //           "Kindly consider to add address regarding place your order");
          // } else {
          //   Loader.showLoader();
          //   await _con.placeOrder(
          //       cart: cartItems,
          //       shipperDetails: storeAddresses[_con.isSelectAdd.value]);
          //   Loader.hideLoader(context);
          // }
          // _con.paymentMethodDialogue();
          Get.to(()=> const WebViewExample());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hSizedBox10,
              Text(
                AppString.selectdeliveryaddress,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              hSizedBox10,
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.addressScreen)?.then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xffD2D2D2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.addnewaddress,
                        height: 25,
                        width: 25,
                      ),
                      wSizedBox10,
                      Text(
                        AppString.addNewAddress,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: storeAddresses.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _con.isSelectAdd.value = index;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  spreadRadius: .5,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageConstant.office,
                                  height: 35,
                                  width: 35,
                                ),
                                wSizedBox20,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Address",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      hSizedBox4,
                                      Text(
                                        "${storeAddresses[index]["firstName"]} ${storeAddresses[index]["lastName"]}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      hSizedBox4,
                                      Text(
                                        storeAddresses[index]["phoneNumber"],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      hSizedBox4,
                                      Text(
                                        storeAddresses[index]["address"],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff707070),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Radio(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  activeColor: AppColors.yellowColor,
                                  value: _con.isSelectAdd.value,
                                  groupValue: index,
                                  onChanged: (val) {
                                    _con.isSelectAdd.value = index;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_con.isSelectAdd.value == index)
                          Positioned(
                            bottom: 30,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.shade300.withOpacity(0.6),
                                    blurRadius: 10.0,
                                    spreadRadius: .5,
                                  ),
                                ],
                              ),
                              child: Text(
                                AppString.defaulttext,
                                style: TextStyle(
                                  color: AppColors.yellowColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
              hSizedBox16,
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: const Color(0xffF3F3F3),
              //     border: Border.all(
              //       color: const Color(0xffD2D2D2),
              //     ),
              //   ),
              //   child: Row(
              //     children: [
              //       Image.asset(
              //         ImageConstant.info,
              //         height: 30,
              //         width: 30,
              //       ),
              //       wSizedBox12,
              //       Expanded(
              //         child: Text(
              //           AppString.info,
              //           style: const TextStyle(
              //             fontWeight: FontWeight.normal,
              //             fontSize: 13,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // hSizedBox36,
            ],
          ),
        ),
      ),
    );
  }
}
