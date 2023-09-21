import 'package:flutter/material.dart';
import 'package:watch_app/utills/color.dart';

class EmptyProduct extends StatelessWidget {
   EmptyProduct({Key? key,this.text}) : super(key: key);
  String? text;



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
       text?? "No Product Available",
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
