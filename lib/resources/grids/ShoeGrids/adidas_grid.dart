import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/color.dart';

class Adidas extends StatefulWidget {
  const Adidas({Key? key}) : super(key: key);

  @override
  State<Adidas> createState() => _AdidasState();
}

class _AdidasState extends State<Adidas> {
  int api = 0;
  List products = [];
  bool adidaLoading = false;
  bool adiLoading = false;

  ScrollController scrollController = ScrollController();

  Future getAdidas() async {
    const yeezy500 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20500";
    const yeezy350 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20350";
    const yeezy380 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20380";
    const yeezy450 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20450";
    const yeezy750 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20750";
    const yeezySlide =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20slide";
    const yeezy700 =
        "https://boolopo.co/apies/productsbytags.php?product_tag=yeezy%20700";
    setState(() {
      adiLoading = true;
    });

    final adidas = await Future.wait([
      http.get(Uri.parse(yeezy500)),
      http.get(Uri.parse(yeezy350)),
      http.get(Uri.parse(yeezy380)),
      http.get(Uri.parse(yeezy450)),
      http.get(Uri.parse(yeezy750)),
      http.get(Uri.parse(yeezy700)),
      http.get(Uri.parse(yeezySlide)),
    ]);

    var adi = adidas[api];
    var adida = jsonDecode(adi.body);
    if (adi.statusCode == 200) {
      products = products + adida["products"];
      setState(() {
        adiLoading = false;
      });
    } else {
      print("Unable to load data from Api");
    }
  }

  notify() {
    if (adidaLoading) return;
    if (scrollController.position.pixels == scrollController.offset) {
      setState(() {
        adidaLoading = true;
      });
      ++api;
      getAdidas();
      setState(() {
        adidaLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAdidas();
    scrollController.addListener(notify);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: GridView.builder(
        controller: scrollController,
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
                                name: title,
                                image: image,
                                price: price,
                                id: id,
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
