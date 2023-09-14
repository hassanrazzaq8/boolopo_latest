import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/utills/color.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key, required this.imageUrl, required this.name})
      : super(key: key);
  final String imageUrl;
  final String name;

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: themeColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      //90, 25, 189, 1
      elevation: 5,

      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
              color: Colors.white,
            ),
            height: double.infinity,
            width: 145,
          ),
          Align(
            alignment: Alignment.topRight,
            // left: 85,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isPressed = !isPressed;
                });
              },
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                child: isPressed
                    ? const Align(
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                          size: 18,
                        ),
                      )
                    : const Align(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
              ),
            ),
          ),
          Align(
            child: Image.asset(
              widget.imageUrl,
              height: 140,
              width: 140,
            ),
          ),
          Align(
            alignment: const Alignment(0, .67),

            child: Text(
              widget.name,
              style: GoogleFonts.oswald(),
            ),
          ),
          Align(
            alignment: const Alignment(0, .95),
            child: Text(
              " \$ 10",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                  color: themeColor, fontSize: 17, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
