import 'package:flutter/material.dart';
import 'package:watch_app/utills/color.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Product Available",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: themeColor,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
