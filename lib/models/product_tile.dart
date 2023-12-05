import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/utills/color.dart';

class ProductTile extends StatefulWidget {
  ProductTile({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.onIconTap,
    this.onProductTap,
    this.isFavourite = false,
    required this.price,
  }) : super(key: key);
  final String imageUrl;
  final String name, price;
  Function()? onIconTap, onProductTap;
  bool isFavourite;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onProductTap,
      child: Card(
        shadowColor: Colors.grey,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        //90, 25, 189, 1
        elevation: 5,

        child: Container(
          width: Get.width * .4,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: widget.onIconTap,
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: widget.isFavourite
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 20,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                            size: 18,
                          ),
                  ),
                ),
              ),
              Align(
                child: SizedBox(
                  height: Get.height * .12,
                  width: double.infinity,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported_rounded,
                        size: Get.height * .1,
                        color: Colors.black26,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else {
                        return child;
                      }
                    },
                  ),
                ),
              ),
              hSizedBox10,
              Text(
                widget.name,
                maxLines: 1,
                style: GoogleFonts.oswald(),
              ),
              Text(
                "  \$${widget.price}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
