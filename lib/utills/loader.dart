import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_app/utills/color.dart';

class Loader {
  static showLoader({
    BuildContext? context,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static hideLoader(BuildContext? context) {
   Get.back();
  }


  static apiLoading({Color? color}) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? themeColor,
      ),
    );
  }
}
