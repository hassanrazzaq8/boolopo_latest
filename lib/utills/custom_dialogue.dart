import 'package:flutter/material.dart';
import 'package:watch_app/core/app_export.dart';

import '../presentation/commamn/app_button.dart';

customDialogue(context,{required String message}){
  return showDialog(context: context, builder: (context) {
return AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  content: Column(
    children: [
      Text(
        message,
        style: const TextStyle(
          color: Color(0xff1EB8AC),
          fontSize: 12,
        ),
      ),
      hSizedBox14,
      AppButton(
        height: Get.height*.05,
        text:  "ok",
        width: Get.width / 3,
        onPressed: () {
          Get.back();
        },
      ),
    ],
  ),
);
  },);
}