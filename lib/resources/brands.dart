import 'package:flutter/material.dart';
import 'package:watch_app/utills/brand_button.dart';
import 'package:watch_app/utills/color.dart';

class Brands extends StatefulWidget {
  Brands({
    Key? key,
    required this.index,
    required this.pageController,
    required this.airJordhan,
    required this.nike,
    required this.adidas,
    required this.converse,
    required this.travis,
    required this.offWhite,
    required this.celine,
    required this.dior,
  }) : super(key: key);
  int index;
  final PageController pageController;
  final airJordhan, nike, adidas, converse, travis, offWhite, celine, dior;

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BrandButton(
                index: widget.index,
                onpressed: () {
                  widget.pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Air Jordhan",
                iNo: 0,
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                onpressed: () {
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Nike",
                iNo: 1,
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                onpressed: () {
                  widget.pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Adidas",
                iNo: 2,
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                iNo: 3,
                onpressed: () {
                  widget.pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Travis Scott",
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                iNo: 4,
                onpressed: () {
                  widget.pageController.animateToPage(
                    4,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "OFF-WHITE",
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                iNo: 5,
                onpressed: () {
                  widget.pageController.animateToPage(
                    5,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Celin Sneakers",
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                iNo: 6,
                onpressed: () {
                  widget.pageController.animateToPage(
                    6,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Dior Sneakers",
              ),
              const SizedBox(
                width: 3,
              ),
              BrandButton(
                index: widget.index,
                onpressed: () {
                  widget.pageController.animateToPage(
                    7,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                title: "Converse",
                iNo: 7,
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: MediaQuery.of(context).size.width * .75,
            child: PageView(
              controller: widget.pageController,
              children: [
                widget.airJordhan,
                widget.nike,
                widget.adidas,
                widget.travis,
                widget.offWhite,
                widget.celine,
                widget.dior,
                widget.converse,
              ],
              onPageChanged: (value) {
                setState(() {
                  widget.index = value;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
