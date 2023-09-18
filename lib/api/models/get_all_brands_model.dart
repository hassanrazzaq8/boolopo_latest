class GetAllBrandsModel {
  String? status;
  List<Brandlist>? brandlist;

  GetAllBrandsModel({this.status, this.brandlist});

  GetAllBrandsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['brandlist'] != null) {
      brandlist = <Brandlist>[];
      json['brandlist'].forEach((v) {
        brandlist!.add(Brandlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (brandlist != null) {
      data['brandlist'] = brandlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brandlist {
  int? termId;
  String? name;
  String? slug;
  int? productCount;

  Brandlist({this.termId, this.name, this.slug, this.productCount});

  Brandlist.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['product_count'] = productCount;
    return data;
  }
}
