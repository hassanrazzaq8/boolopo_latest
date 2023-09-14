// import 'package:flutter/cupertino.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:watch_app/models/wallet.dart';

// class FavouriteProvider extends ChangeNotifier {
//   List<Wallet> _favItems = [];
//   List get favItems => _favItems;

//   void favourite(Wallet item) {
//     final exists = _favItems.contains(item);
//     if (exists) {
//       _favItems.remove(item);
//     } else {
//       _favItems.add(item);
//     }
//     GetStorage().write("favourites", _favItems);
//     notifyListeners();
//   }

//   bool isFavourite(Wallet item) {
//     List exists = GetStorage().read("favourites");
//     if (exists != null) {
//       if (exists.contains(item)) {
//         return true;
//       }
//     } else {
//       return false;
//     }
//     return false;
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class FavoProvider extends ChangeNotifier {
  List _hallo = [];

  List get hallo => _hallo;
  void favorite(String word, String price, String image) {
    if (GetStorage().read("fav") != null) {
      _hallo = GetStorage().read("fav");
    }
    var exists = _hallo.where((value) => (value["title"].contains(word)));

    if (exists.isEmpty) {
      _hallo.add({
        "title": word,
        "price": price,
        "image": image,
      });
      GetStorage().write("fav", _hallo);
    } else {
      return;
    }
    notifyListeners();
  }

  void removeFromfavorite(String word) {
    List local = GetStorage().read("fav");
    var exists = local.where((value) => (value["title"].contains(word)));
    if (exists.isNotEmpty) {
      print(word);
      local.removeWhere((value) => (value["title"].contains(word)));
      GetStorage().write("fav", _hallo);
      notifyListeners();
    }
  }

  bool isFavourite(String word) {
    if (GetStorage().read("fav") != null) {
      _hallo = GetStorage().read("fav");
    }
    var exist = _hallo.where((value) => (value["title"] == word));
    if (exist.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  // else {
  //   return false;
  // }
  // }

  void clearAll() {
    _hallo.clear();
    // GetStorage().remove("favou");
  }
}
