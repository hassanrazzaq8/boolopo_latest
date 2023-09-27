import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class ProviderCart extends ChangeNotifier {
  List _cart = [];

  List get cart => _cart;

  void addToCart(
      String id, String title, String price, int quantity, String image,String size) {
    if (GetStorage().read("myCart") != null) {
      _cart = GetStorage().read("myCart");
    }
    final exists = _cart.where((value) => (value["id"] == id));
    if (exists.isEmpty) {
      _cart.add(
        {
          "product_id": id,
          "product_name": title,
          "product_price": price,
          "product_qty": quantity,
          "image": image,
          "size":size,
        },
      );
      GetStorage().write("myCart", _cart);
    } else {
      return;
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    List local = GetStorage().read("myCart");
    final exists = local.where((value) => (value["product_id"] == id));
    if (exists.isNotEmpty) {
      local.removeWhere((value) => (value["product_id"] == id));
      print(id);
      GetStorage().write("myCart", local);
    }
    notifyListeners();
  }

  int totalPrice() {
    int total=0;
    String init;
    int count;
    if (GetStorage().read("myCart") != null) {
      _cart = GetStorage().read("myCart");

      for (var i = 0; i < _cart.length; i++) {
        init = _cart[i]["product_price"];

        count = _cart[i]["product_qty"];
        var p = int.parse(init);
        debugPrint("p is : $p");
        total = total + p * count;
      }
    }
    return total;
  }

  bool isAdded(int id) {
    if (GetStorage().read("myCart") != null) {
      _cart = GetStorage().read("myCart");
    }
    var exist = _cart.where((value) => (value["id"] == id));
    if (exist.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  int get cartItems {
    _cart = GetStorage().read("myCart") ?? [];
    // notifyListeners();
    return _cart.length;
  }
  void clearAll() {
    _cart.clear();
    GetStorage().remove("myCart");
    notifyListeners();
  }
}
