import 'package:flutter/material.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/models/product_tile.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';

class BagGrid extends StatelessWidget {
  const BagGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: GridView.count(
        childAspectRatio: 1 / 1.5,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ProductDetail(
          //           image: ImageConstant.bag,
          //           name: "bag name",
          //         ),
          //       ),
          //     );
          //   },
          //   child: const Grid(
          //     imageUrl: ImageConstant.bag,
          //     name: "Bag Name",
          //   ),
          // ),
        ],
      ),
    );
  }
}
