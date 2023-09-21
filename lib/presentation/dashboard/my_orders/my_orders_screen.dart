import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/empty_product.dart';
import 'package:watch_app/utills/loader.dart';

import 'my_orders_controller.dart';

class MyOrdersScreen extends StatefulWidget {
  MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final MyOrderController _con = Get.put(MyOrderController());

  @override
  void initState() {
    super.initState();
    _con.getOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async{
          Get.offAllNamed(AppRoutes.bottomBarScreen);
          return false;
        },
        child: Scaffold(
          appBar: appBar(
            text: AppString.myOrders,
            back: true,
            actionIcon: true,
            leadingPressed: () {
              Get.offAllNamed(AppRoutes.bottomBarScreen);
            },
          ),
          body: _con.ordersFetch.value
              ? _con.getOrdersModel.orderlist!.isNotEmpty
                  ? ListView.builder(
                      itemCount: _con.getOrdersModel.orderlist?.length ?? 0,
                      itemBuilder: (context, index) {
                        return orderTile(
                          orderId: _con.getOrdersModel.orderlist?[index].orderId
                              .toString(),
                          orderAmount:
                              _con.getOrdersModel.orderlist?[index].orderAmount,
                          orderStatus:
                              _con.getOrdersModel.orderlist?[index].orderStatus,
                          orderDate:
                              _con.getOrdersModel.orderlist?[index].orderDate?.split(' ').first,
                        );
                      },
                    )
                  : EmptyProduct(
                      text: "No orders Available",
                    )
              : Loader.apiLoading(),
        ),
      ),
    );
  }

  orderTile({
    String? orderId,
    String? orderAmount,
    String? orderStatus,
    String? orderDate,
  }) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: themeColor)),
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .05,
        vertical: Get.height * .015,
      ),
      padding: EdgeInsets.all(Get.width * .05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Id: ",
                style: TextStyle(
                  fontSize: Get.textScaleFactor * 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                orderId ?? "",
                style: TextStyle(
                  fontSize: Get.textScaleFactor * 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Amount",
                style: TextStyle(
                  fontSize: Get.textScaleFactor * 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                orderAmount ?? "",
                style: TextStyle(
                  fontSize: Get.textScaleFactor * 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * .02),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Order Status",
                      style: TextStyle(
                        fontSize: Get.textScaleFactor * 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text(
                      orderStatus ?? "",
                      style: TextStyle(
                        fontSize: Get.textScaleFactor * 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                wSizedBox8,
                Container(
                  width: 2,
                  color: Colors.grey.shade400,
                ),
                wSizedBox8,
                Column(
                  children: [
                    Text(
                      "Created At",
                      style: TextStyle(
                        fontSize: Get.textScaleFactor * 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text(
                      orderDate ?? "2023-11-10",
                      style: TextStyle(
                        fontSize: Get.textScaleFactor * 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
