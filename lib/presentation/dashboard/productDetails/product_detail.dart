import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/models/product_details_model.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_screen.dart';
import 'package:watch_app/providers/cart_provider.dart';
import 'package:watch_app/providers/favourite_provider.dart';
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
  final int count = 1;
  String? review;

  @override
  void initState() {
    super.initState();
    getProductDetails(widget.id).then((value) {
      if (value) {
        getRating();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ProviderCart>(context);
    final favouriteProvider = Provider.of<FavoProvider>(context);

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
        bottomNavigationBar: detailsFetch
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        favouriteProvider.favorite(
                          productDetailsModel.name!,
                          productDetailsModel.price!,
                          productDetailsModel.images?.first.src ?? "",
                          productDetailsModel.id.toString(),
                        );
                      },
                      icon: favouriteProvider
                              .isFavourite(productDetailsModel.name!)
                          ? Icon(
                              Icons.favorite,
                              color: Colors.grey.shade800,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.grey.shade800,
                            ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          minimumSize: const Size(150, 50)),
                      onPressed: () {
                        if (Storage.isUserLogin) {
                          if(selectedSize!=null){
                            cartProvider.addToCart(
                              widget.id,
                              productDetailsModel.name ?? "",
                              productDetailsModel.price ?? "",
                              count,
                              productDetailsModel.images?.first.src ?? "",
                            );
                            showSnackBar("Product added to your cart", context);
                            Navigator.pop(context);
                          }else{
                            customDialogue(message: "Please select size of your product to continue");
                          }

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
              )
            : const SizedBox.shrink(),
        body: detailsFetch
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          productDetailsModel.name ?? "",
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
                              height: MediaQuery.of(context).size.height * .38,
                              width: double.infinity,
                              child: Image.network(
                                productDetailsModel.images?.first.src ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image_not_supported_rounded,
                                    size: Get.height * .3,
                                    color: Colors.black26,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
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
                                Text(
                                  " \$ ${productDetailsModel.price ?? ""}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: double.parse(review ?? "0.0"),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.zero,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: themeColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: Get.width,
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 4,
                                              width: Get.width * 0.22,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "What is Your Rate",
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            RatingBar.builder(
                                              initialRating:
                                                  double.parse(rating ?? "2.0"),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (value) {
                                                setState(() {
                                                  rating = value.toString();
                                                });
                                                print("rating : $rating");
                                              },
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Please Share your Opinion",
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22),
                                            ),
                                            Text(
                                              "About the Product",
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: Get.height * 0.2,
                                              width: Get.width * 0.85,
                                              color: Colors.white,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    comment = value;
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Your review',
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                addRating();
                                              },
                                              child: Container(
                                                height: 42,
                                                width: Get.width * 0.5,
                                                decoration: BoxDecoration(
                                                    color: themeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: const Center(
                                                  child: Text(
                                                    "Send Reviews",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.3,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              child: Center(
                                child: Text(
                                  "ADD REVIEW",
                                  style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      hSizedBox10,
                      Container(
                        height: Get.height * 0.07,
                        width: Get.width,
                        // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 0,
                                offset: const Offset(0, 3),
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Get.height * .01),
                            ),
                            border: Border.all(color: Colors.black)),
                        child: ButtonTheme(
                          child: DropdownButton<dynamic>(
                            menuMaxHeight: Get.height * .55,
                            hint: const Text(
                              "Select the Size",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                              ),
                            ),
                            value: selectedSize,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                              size: Get.height * .035,
                            ),
                            underline: const SizedBox(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedSize = newValue;
                              });
                            },
                            items:
                                productDetailsModel.attributes!.first.options!
                                    .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        )))
                                    .toList(),
                          ),
                        ),
                      ),
                      hSizedBox10,
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
                      hSizedBox10,
                    ],
                  ),
                ),
              )
            : Loader.apiLoading(color: Colors.black),
      ),
    );
  }

  ProductDetailsModel productDetailsModel = ProductDetailsModel();
  bool detailsFetch = false;
  String? rating = "2.0", comment;
  String? selectedSize;

  Future<bool> getProductDetails(String productId) async {
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
        setState(() {
          detailsFetch = true;
        });
        return false;
      } else {
        debugPrint("product name is : ${productDetailsModel.name}");
        setState(() {
          detailsFetch = true;
        });
        return true;
      }
    } catch (err) {
      debugPrint("error while fetching product details : $err");
      return false;
    }
  }

  Future<void> getRating() async {
    try {
      Map<String, dynamic> formData = {
        "prduct_id": productDetailsModel.id.toString()
      };
      final data = await Api.postMethod(url: getRatingsApi, body: formData);
      if (data != null) {
        setState(() {
          review = data["rating"];
        });
      }
      print("data is : $data");
    } catch (err) {
      debugPrint("error during fetching rating : $err");
    }
  }

  Future<void> addRating() async {
    try {
      int userId = GetStorage().read(AppString.userId);
      Map<String, dynamic> formData = {
        "user_id": userId.toString(),
        "product_id": productDetailsModel.id.toString(),
        "rating": rating ?? "",
        "comment_content": comment ?? "",
      };
      debugPrint("form data : $formData");
      final data = await Api.postMethod(
        url: addRatingsApi,
        body: formData,
      );
      if (data != null) {
        if (data["status"] == "success") {
          customDialogue(message: "Your review has been submitted");
        } else {
          customDialogue(message: data["status"]);
        }
      }
      print("data is : $data");
    } catch (err) {
      debugPrint("error during adding rating : $err");
      Loader.hideLoader(context);
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:watch_app/core/utils/image_constant.dart';
//
// import '../../../utills/color.dart';
// import '../../bottomBar/bottombar_screen.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class ProductDetail extends StatefulWidget {
//   const ProductDetail({
//     Key? key, required this.id,
//
//   }) : super(key: key);
//   final String id;
//
//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }
//
// class _ProductDetailState extends State<ProductDetail> {
//
//   int size = 0;
//   bool isRated = false;
//   String review="";
//
//   TextEditingController sizeController = TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     sizeController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget rate(bool state) {
//       return InkWell(
//         onTap: () {
//           state != state;
//           setState(() {});
//         },
//         child: state
//             ? const Icon(
//           Icons.star,
//           color: Colors.red,
//         )
//             : const Icon(
//           Icons.star_border,
//           color: Colors.black,
//         ),
//       );
//     }
//
//     return MaterialApp(
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Colors.blue,
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.black,
//               size: 20,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           title: Text(
//             "BOO--LOPO",
//             style: GoogleFonts.oswald(
//               color: Colors.black,
//             ),
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               onPressed: () {
//               },
//               icon: Image.asset(ImageConstant.menu),
//               iconSize: 20,
//             ),
//           ],
//         ),
//         drawer: BottomBarScreenState().drawerOpen(),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(bottom: 18.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.favorite,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     primary: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                         17,
//                       ),
//                     ),
//                     minimumSize: const Size(150, 45)),
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 child: Text(
//                   "Add To Cart",
//                   style: GoogleFonts.oswald(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.shopping_cart,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Text(
//                    " widget.name",
//                     style: GoogleFonts.oswald(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 18.0),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     // color: const Color.fromARGB(248, 9, 34, 90).withOpacity(.40),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .40,
//                         width: double.infinity,
//                         child: Align(
//                           child: Image.network("")
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 " \$ {widget.price}",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold,
//                                   color: themeColor,
//                                   fontStyle: FontStyle.italic,
//                                 ),
//                               ),
//                               const Text("  Free Shipping!",
//                                   style:
//                                   TextStyle(fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Text("COULDN'T FIND YOUR SIZE?"),
//                 ),
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: TextField(
//                     controller: sizeController,
//                     decoration: const InputDecoration(
//                       hintText: "Write your size here in US or EUR",
//                       border: OutlineInputBorder(),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
