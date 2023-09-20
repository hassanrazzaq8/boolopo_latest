import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class ProviderCart extends ChangeNotifier {
  List _cart = [];
  List get cart => _cart;

  void addToCart(
      String id, String title, String price, double quantity, String image) {
    if (GetStorage().read("mycart") != null) {
      _cart = GetStorage().read("mycart");
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
        },
      );
      GetStorage().write("mycart", _cart);
    } else {
      return;
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    List local = GetStorage().read("mycart");
    final exists = local.where((value) => (value["id"] == id));
    if (exists.isNotEmpty) {
      local.removeWhere((value) => (value["id"] == id));
      print(id);
      GetStorage().write("mycart", local);
    }
    notifyListeners();
  }

  double totalPrice() {
    double total = 0.0;
    String init;
    double count;
    if (GetStorage().read("mycart") != null) {
      _cart = GetStorage().read("mycart");
    }
    for (var i = 0; i < _cart.length; i++) {
      init = _cart[i]["product_price"];

      count = _cart[i]["product_qty"];
      double p = double.parse(init);
      total = total + p * count;
    }
    return total;
  }

  bool isAdded(int id) {
    if (GetStorage().read("mycart") != null) {
      _cart = GetStorage().read("mycart");
    }
    var exist = _cart.where((value) => (value["id"] == id));
    if (exist.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearAll() {
    _cart.clear();
    GetStorage().remove("mycart");
    notifyListeners();
  }
}
