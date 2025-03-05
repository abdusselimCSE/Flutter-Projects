import 'package:sum_app/features/common/data/models/product_model.dart';

class ProductDetailsModel {
  int? code;
  String? status;
  String? msg;
  Product? data;

  ProductDetailsModel({this.code, this.status, this.msg, this.data});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      data: json['data'] != null ? Product.fromJson(json['data']) : null,
    );
  }
}

class Brand {
  String? id;
  String? title;
  String? slug;
  String? icon;

  Brand({this.id, this.title, this.slug, this.icon});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'slug': slug,
      'icon': icon,
    };
  }
}

class Category {
  String? id;
  String? title;
  String? slug;
  String? icon;

  Category({this.id, this.title, this.slug, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }
}
