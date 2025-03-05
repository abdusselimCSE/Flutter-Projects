import 'package:sum_app/features/common/data/models/product_model.dart';

class ProductListByCategoryModel {
  int? code;
  String? status;
  String? msg;
  ProductData? data;

  ProductListByCategoryModel({this.code, this.status, this.msg, this.data});

  factory ProductListByCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductListByCategoryModel(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
    );
  }
}

class ProductData {
  List<Product>? results;
  int? total;
  dynamic firstPage;
  dynamic previous;
  int? next;
  int? lastPage;

  ProductData(
      {this.results,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      results: json['results'] != null
          ? List<Product>.from(json['results'].map((v) => Product.fromJson(v)))
          : [],
      total: json['total'],
      firstPage: json['first_page'],
      previous: json['previous'],
      next: json['next'],
      lastPage: json['last_page'],
    );
  }
}
