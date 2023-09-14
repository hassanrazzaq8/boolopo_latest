import 'package:flutter/material.dart';

class CartModel {
  late final int id;
  final String pId;
  final String? pName;
  final int? pInitialPrice;
  final int? pPrice;
  final String? image;
  final ValueNotifier<int>? quantity;

  CartModel({
    required this.id,
    required this.pName,
    required this.pInitialPrice,
    required this.pPrice,
    required this.pId,
    required this.image,
    required this.quantity,
  });
  CartModel.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        pName = data['productName'],
        pInitialPrice = data['initialPrice'],
        pPrice = data['productPrice'],
        pId = data['ProductId'],
        image = data['image'],
        quantity = ValueNotifier(data['quantity']);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ProductId': pId,
      'productName': pName,
      'initialPrice': pInitialPrice,
      'productPrice': pPrice,
      'image': image,
      'quantity': quantity?.value,
    };
  }

  quantityMap() {
    return quantity;
  }
}
