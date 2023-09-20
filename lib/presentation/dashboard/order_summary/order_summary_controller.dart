import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/utills/custom_dialogue.dart';

class OrderSummaryController extends GetxController {
  RxInt isSelectAdd = 0.obs;

  Future<bool> placeOrder({
    required List cart,
    required Map<String, dynamic> shipperDetails,
  }) async {
    try {
      int userId = GetStorage().read(AppString.userId);
      Map<String, dynamic> body = {
        "user_id": userId,
        "shiping_first_name": shipperDetails["firstName"],
        "shiping_last_name": shipperDetails["lastName"],
        "shiping_email": shipperDetails["email"],
        "shiping_phone": shipperDetails["phoneNumber"],
        "shiping_address": shipperDetails["address"],
        "shiping_country": shipperDetails["country"],
        "shiping_city": "test",
        "shiping_state": shipperDetails["state"],
        "shiping_post_code": shipperDetails["postcode"],
        "items_list": cart,
      };
      jsonEncode(body);
      debugPrint("body is : $body");
      var data = await Api.postMethod(url: placeOrderApi, body: body);
      if (data != null) {
        paymentMethodDialogue();
      } else {
        customDialogue(message: AppString.badHappenedError);
      }
      debugPrint("data response if I am in luck : $data");

      return true;
    } catch (err) {
      return false;
    }
  }

  paymentMethodDialogue() {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a Payment Method",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              hSizedBox14,
              AppButton(
                width: Get.width / 2,
                height: Get.height * .06,
                text: "Payrexx",
              ),
              hSizedBox14,
              AppButton(
                height: Get.height * .06,
                text: "Coinbase",
                width: Get.width / 2,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
