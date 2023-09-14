import 'package:flutter/material.dart';
import 'package:watch_app/utills/color.dart';

class BrandButton extends StatefulWidget {
  BrandButton({
    Key? key,
    required this.index,
    this.controller,
    required this.onpressed,
    required this.title,
    required this.iNo,
  }) : super(key: key);
  final int index;
  final controller;
  void Function()? onpressed;
  final String title;
  final int iNo;

  @override
  State<BrandButton> createState() => _BrandButtonState();
}

class _BrandButtonState extends State<BrandButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.index == widget.iNo ? themeColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: widget.onpressed,
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: widget.index == widget.iNo ? Colors.white : Colors.black,
              ),
            ),
            Container(
              height: 1,
              width: 30,
              color: themeColor,
            )
          ],
        ),
      ),
    );
  }
}
