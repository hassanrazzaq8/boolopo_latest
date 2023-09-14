import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/color.dart';

class Nike extends StatefulWidget {
  const Nike({Key? key}) : super(key: key);

  @override
  State<Nike> createState() => _NikeState();
}

class _NikeState extends State<Nike> {
  List products = [];
  int api = 0;
  bool isLoading = false;
  bool loading = false;
  ScrollController controller = ScrollController();

  Future getShoes() async {
    setState(() {
      loading = true;
    });

    var airForce1 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=Air%20force%201";
    var airMax =
        "https://boolopo.co/apies/productsbytags.php?product_tag=Air%20max";
    var sbDunk =
        "https://boolopo.co/apies/productsbytags.php?product_tag=SB%20Dunk";
    var airFog =
        "https://boolopo.co/apies/productsbytags.php?product_tag=Air%20fog";
    var blazer =
        "https://boolopo.co/apies/productsbytags.php?product_tag=Blazer";
    var vapormax =
        "https://boolopo.co/apies/productsbytags.php?product_tag=vapormax";
    var kobeBryant =
        "https://boolopo.co/apies/productsbytags.php?product_tag=kobe%20bryant";
    var vapourWaffle =
        "https://boolopo.co/apies/productsbytags.php?product_tag=vaporwaffle";

    final nik = await Future.wait([
      http.get(Uri.parse(airForce1)),
      http.get(Uri.parse(airMax)),
      http.get(Uri.parse(sbDunk)),
      http.get(Uri.parse(airFog)),
      http.get(Uri.parse(blazer)),
      http.get(Uri.parse(vapormax)),
      http.get(Uri.parse(kobeBryant)),
      http.get(Uri.parse(vapourWaffle)),
    ]);
    var last = nik[api];
    var nikee = jsonDecode(last.body.toString());
    if (last.statusCode == 200) {
      products = products + nikee["products"];

      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  scrolling() async {
    if (isLoading) return;
    if (controller.position.pixels == controller.offset) {
      setState(() {
        isLoading = true;
      });
      ++api;
      print("object");
      await getShoes();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getShoes();
    controller.addListener(scrolling);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: GridView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: products.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.5,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          if (index < products.length) {
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
                          height: 140,
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
                                    color: Colors.red,
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
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: CircularProgressIndicator(
                color: themeColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
