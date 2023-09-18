class GetProductsByBrandModel {
  String? status;
  int? totalpage;
  List<Products>? products;

  GetProductsByBrandModel({this.status, this.totalpage, this.products});

  GetProductsByBrandModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalpage = json['totalpage'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalpage'] = totalpage;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? num;
  int? productId;
  String? title;
  String? description;
  String? shortDescription;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? productImg;

  Products(
      {this.num,
        this.productId,
        this.title,
        this.description,
        this.shortDescription,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.productImg});

  Products.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    productId = json['product_id'];
    title = json['title'];
    description = json['description'];
    shortDescription = json['short_description'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    productImg = json['product_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['product_id'] = productId;
    data['title'] = title;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['product_img'] = productImg;
    return data;
  }
}
