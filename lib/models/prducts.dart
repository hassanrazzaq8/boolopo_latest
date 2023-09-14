// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    required this.status,
    required this.products,
  });

  String status;
  List<Product> products;

  factory Products.fromJson(Map json) => Products(
        status: json["status"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.productId,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.productImg,
  });

  int productId;
  String title;
  String description;
  String shortDescription;
  String price;
  String regularPrice;
  String salePrice;
  String productImg;

  factory Product.fromJson(Map json) => Product(
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        shortDescription: json["short_description"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        productImg: json["product_img"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "title": title,
        "description": description,
        "short_description": shortDescription,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "product_img": productImg,
      };
}
