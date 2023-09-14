import 'package:flutter/material.dart';
import 'package:watch_app/utills/color.dart';

class Loader {
  static showLoader({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async{
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
        );
      },
    );
  }

  static hideLoader(BuildContext context) {
    Navigator.of(context).pop();
  }
}
