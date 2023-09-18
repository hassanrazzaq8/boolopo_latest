import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/models/product_details_model.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_screen.dart';
import 'package:watch_app/providers/cart_provider.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/loader.dart';
import 'package:watch_app/utills/snack_bar.dart';
import 'package:watch_app/utills/storage.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,

    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  int size = 0;
  bool isRated = false;
  TextEditingController sizeController = TextEditingController();
  final double count = 1;

  @override
  void initState() {
    super.initState();
    getProductDetails(widget.id);
  }
  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCart>(context);

    Widget rate(bool state) {
      return InkWell(
        onTap: () {},
        child: state
            ? const Icon(
                Icons.star,
                color: Colors.grey,
              )
            : const Icon(
                Icons.star_border,
                color: Colors.grey,
              ),
      );
    }

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "BOO--LOPO",
            style: GoogleFonts.oswald(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                scaffoldkey.currentState!.openDrawer();
              },
              icon: Image.asset(ImageConstant.menu),
              iconSize: 20,
            ),
          ],
        ),
        drawer: BottomBarScreenState().drawerOpen(),
        bottomNavigationBar:detailsFetch? Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey.shade800,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    minimumSize: const Size(150, 50)),
                onPressed: () {
                  if (Storage.isUserLogin) {
                    provider.addToCart(
                      widget.id,
                      productDetailsModel.name??"",
                      productDetailsModel.price??"",
                      count,
                      productDetailsModel.images?.first.src??"",
                    );
                    showSnackBar("Product added to your cart", context);
                    Navigator.pop(context);
                  } else {
                    Get.offAllNamed(AppRoutes.loginScreen);
                  }
                },
                child: const Text("Add To Cart"),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ):const SizedBox.shrink(),
        body:detailsFetch? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    productDetailsModel.name??"",
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // color: const Color.fromARGB(248, 9, 34, 90).withOpacity(.40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .40,
                        width: double.infinity,
                        child:Image.network(
                          productDetailsModel.images?.first.src??"",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported_rounded,
                              size: Get.height * .3,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                " \$ ${ productDetailsModel.price??""}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                "price",
                                style: GoogleFonts.robotoMono(
                                  // fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  rate(true),
                                  rate(true),
                                  rate(true),
                                  rate(false),
                                  rate(false),
                                ],
                              ),
                              Text(
                                " Rating",
                                style: GoogleFonts.robotoMono(
                                  // fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("COULDN'T FIND YOUR SIZE?"),
                ),
                const SizedBox(
                  height: 2,
                ),
                TextField(
                    controller: sizeController,
                    decoration: const InputDecoration(
                      hintText: "Write your size here in US or EUR",
                      border: OutlineInputBorder(),
                    )),
              ],
            ),
          ),
        ):Loader.apiLoading(color: Colors.black),
      ),
    );
  }

  ProductDetailsModel productDetailsModel = ProductDetailsModel();
bool detailsFetch=false;
  Future<void> getProductDetails(String productId) async {
    try {
      Map<String, dynamic> parameters = {
        "consumer_key": "ck_f5374351dfaa2587fbdf22bc691eeb88e87731bc",
        "consumer_secret": "cs_01c326a844bbdf18e1b54a2de7e5a238f8e73eb5",
      };
      var data = await Api.getMethod(
        context,
        url: "$getProductDetailsApi/$productId",
        parameters: parameters,
      );

      productDetailsModel = ProductDetailsModel.fromJson(data);
      if (productDetailsModel.name == null) {
        customDialogue(
          message:
              "Something went wrong Please Check the internet connection or restart the application",
        );
      } else {
        debugPrint("product name is : ${productDetailsModel.name}");
      }
      setState(() {
        detailsFetch=true;
      });
    } catch (err) {
      debugPrint("error while fetching product details : $err");
    }
  }
}
