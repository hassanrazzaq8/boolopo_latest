import 'dart:convert';

class Wallet {
  final String name;
  final String image;

  Wallet(
    this.name,
    this.image,
  );
  // factory Wallet.fromJson(Map<String, dynamic> jsonData) {
  //   return Wallet(
  //     jsonData['name'],
  //     jsonData['image'],
  //   );
  // }
  // static Map<String, dynamic> toMap(Wallet wallet) => {
  //       "name": wallet.name,
  //       "image": wallet.image,
  //     };

  // static String encode(List<Wallet> wallet) => json.encode(
  //       wallet
  //           .map<Map<String, dynamic>>((wallet) => Wallet.toMap(wallet))
  //           .toList(),
  //     );

  // static List<Wallet> decode(wallets) => (json.decode(wallets) as List<dynamic>)
  //     .map<Wallet>((item) => Wallet.fromJson(item))
  //     .toList();
}
