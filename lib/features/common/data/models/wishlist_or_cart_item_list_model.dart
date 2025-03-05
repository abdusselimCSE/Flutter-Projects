import 'package:sum_app/features/common/data/models/product_model.dart';

class WishlistOrCartItemListModel {
  int? code;
  String? status;
  String? msg;
  Data? data;

  WishlistOrCartItemListModel({this.code, this.status, this.msg, this.data});

  factory WishlistOrCartItemListModel.fromJson(Map<String, dynamic> json) {
    return WishlistOrCartItemListModel(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  List<Results>? results;
  int? total;
  dynamic firstPage;
  dynamic previous;
  dynamic next;
  dynamic lastPage;

  Data(
      {this.results,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      results: json['results'] != null
          ? List<Results>.from(json['results'].map((v) => Results.fromJson(v)))
          : [],
      total: json['total'],
      firstPage: json['first_page'],
      previous: json['previous'],
      next: json['next'],
      lastPage: json['last_page'],
    );
  }
}

class Results {
  String? id;
  Product? product;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? v;

  Results(
      {this.id,
      this.product,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['_id'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      user: json['user'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
