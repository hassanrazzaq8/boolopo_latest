import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/color.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List x;
  // List<Wallet> wods = [];
  @override
  void initState() {
    super.initState();
    if (GetStorage().read("fav") != null) {
      x = GetStorage().read("fav");
    } else {
      x = [];
    }

    // wods = Wallet.decode(x);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoProvider>(context);

    return Scaffold(
      body: x.isEmpty
          ? Column(
              children: [
                Image.asset(ImageConstant.noFav),
                const Text("No favorite yet")
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: x.length,
                itemBuilder: (context, index) {
                  final item = x[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: GridTile(
                      footer: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"],
                            maxLines: 1,
                            style: GoogleFonts.oswald(),
                          ),
                          Text(
                            "   \$${item["price"]}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
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
                                      id: 1,
                                      image: item["image"],
                                      name: item["title"],
                                      price: item["price"],
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                item["image"],
                                height: 100,
                                width: 140,
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: const Alignment(0, .67),
                          //   child:
                          // ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                provider.removeFromfavorite(item["title"]);
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
                                child: const Align(
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
                },
              ),
            ),
    );
  }
}