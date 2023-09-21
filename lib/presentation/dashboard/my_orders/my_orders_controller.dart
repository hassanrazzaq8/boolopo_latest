import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/models/order_model.dart';
import 'package:watch_app/utills/custom_dialogue.dart';

class MyOrderController extends GetxController {
  GetOrdersModel getOrdersModel=GetOrdersModel();
RxBool ordersFetch=false.obs;
  Future<void> getOrders(context) async {
    try {
      int userId=GetStorage().read(AppString.userId);
      Map<String, dynamic> params={
        "userid":userId.toString(),
        "ordertype":"all",
      };
      ordersFetch.value=false;
      var data = await Api.getMethod(context, url: getOrdersApi,parameters: params);
      getOrdersModel = GetOrdersModel.fromJson(data);
      if (getOrdersModel.orderlist == null) {
        customDialogue(
          message:
          "Something went wrong Please Check the internet connection or restart the application",
        );
      }else{
debugPrint("Orders fetched with length : ${getOrdersModel.orderlist?.length}");
      }
      ordersFetch.value=true;
    } catch (err) {
      debugPrint("error while fetching brands : $err");
      ordersFetch.value=true;
    }
  }

}
