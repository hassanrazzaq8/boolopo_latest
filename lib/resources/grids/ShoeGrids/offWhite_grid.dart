import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/color.dart';

class Offwhite extends StatefulWidget {
  const Offwhite({Key? key}) : super(key: key);

  @override
  State<Offwhite> createState() => _OffwhiteState();
}

class _OffwhiteState extends State<Offwhite> {
  List products = [];
  bool isShow = false;
  Future getoffWhite() async {
    setState(() {
      isShow = true;
    });
    const url =
        "https://boolopo.co/apies/productsbytags.php?product_tag=OFF%20WHITE";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      products = body["products"];
      setState(() {
        isShow = false;
      });
      return products;
    } else {
      print("Unable to load api");
    }
  }

  @override
  void initState() {
    super.initState();
    getoffWhite();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: isShow
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.5,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: GridTile(
                      child: Container(
                        color: Colors.white,
                      ),
                    ));
              },
            )
          :
          // FutureBuilder(
          //   builder: (context, snapshot) => snapshot.connectionState ==
          //           ConnectionState.waiting
          // ? const Center(
          //     child: CircularProgressIndicator(),
          //   )
          //       :
          GridView.builder(
              // controller: scrollController,
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.5,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                // if (index < products.length) {
                String title = products[index]["title"];
                String image = products[index]["product_img"];
                String price = products[index]["price"];
                int id = products[index]["product_id"];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: GridTile(
                    footer: Text(
                      " \$ $price",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    id: id,
                                    name: title,
                                    image: image,
                                    price: price,
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              image,
                              height: 100,
                              width: 140,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, .67),
                          child: Text(
                            title,
                            maxLines: 1,
                            style: GoogleFonts.oswald(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              provider.favorite(title, price, image);
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
                              child: !provider.isFavourite(title)
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
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // }

                // return Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 32.0),
                //   child: Center(
                //     child: CircularProgressIndicator(
                //       color: themeColor,
                //     ),
                //   ),
                // );
              },
            ),
      // ),
    );
  }
}
