// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:watch_app/core/app_export.dart';
// import 'package:watch_app/models/wallet.dart';
// import 'package:watch_app/presentation/dashboard/productDetails/product_detail.dart';
// import 'package:watch_app/providers/favourite_provider.dart';
// import 'package:watch_app/utills/color.dart';

// class WalletGrids extends StatefulWidget {
//   const WalletGrids({Key? key}) : super(key: key);

//   @override
//   State<WalletGrids> createState() => _WalletGridsState();
// }

// class _WalletGridsState extends State<WalletGrids> {
//   List<Wallet> wallet = [
//     Wallet('Gucci wallet 1', ImageConstant.wallet),

//     Wallet('Gucci wallet 2', ImageConstant.wallet),

//     // {'Gucci wallet 3', ImageConstant.wallet},
//     // {'LV Wallet 1', ImageConstant.wallet},
//     // {'LV Wallet 2', ImageConstant.wallet},
//     // {'LV Wallet 3', ImageConstant.wallet},
//     // {'LV Wallet 4', ImageConstant.wallet},
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<FavouriteProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.only(top: 28.0),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: 1 / 1.5,
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: wallet.length,
//         itemBuilder: (context, index) {
//           final item = wallet[index];
//           return Card(
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(
//                 15,
//               ),
//             ),
//             child: GridTile(
//               footer: Text(
//                 " \$ 10",
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   color: themeColor,
//                   fontSize: 17,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                         15,
//                       ),
//                       color: Colors.white,
//                     ),
//                     height: double.infinity,
//                     width: 145,
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: IconButton(
//                       onPressed: () {
//                         provider.favourite(item);
//                       },
//                       icon: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(
//                             15,
//                           ),
//                           border: Border.all(
//                             width: 2,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         child: !provider.isFavourite(item)
//                             ? const Align(
//                                 child: Icon(
//                                   Icons.favorite_border,
//                                   color: Colors.grey,
//                                   size: 18,
//                                 ),
//                               )
//                             : const Align(
//                                 child: Icon(
//                                   Icons.favorite,
//                                   color: Colors.red,
//                                   size: 20,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductDetail(
//                                 image: ImageConstant.wallet,
//                                 name: wallet[index].toString()),
//                           ),
//                         );
//                       },
//                       child: Image.asset(
//                         ImageConstant.wallet,
//                         height: 140,
//                         width: 140,
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: const Alignment(0, .67),
//                     child: Text(
//                       wallet[index].name,
//                       style: GoogleFonts.oswald(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
