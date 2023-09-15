import 'package:flutter/material.dart';
import 'package:watch_app/core/app_export.dart';

import '../presentation/commamn/app_button.dart';

customDialogue(
  context, {
  required String message,
  Function()? onOkTap,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            hSizedBox14,
            AppButton(
              height: Get.height * .06,
              text: "ok",
              width: Get.width / 4,
              onPressed: () {
                if (onOkTap != null) {
                  onOkTap();
                } else {
                  Get.back();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
