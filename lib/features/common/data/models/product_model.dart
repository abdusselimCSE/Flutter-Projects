import 'package:sum_app/features/product/data/models/product_details_model.dart';

class Product {
  String? id;
  String? title;
  Brand? brand;
  List<Category>? categories;
  String? slug;
  String? metaDescription;
  String? description;
  List<String>? photos;
  List<String>? colors;
  List<String>? sizes;
  List<String>? tags;
  dynamic regularPrice;
  int? currentPrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  int? v;

  Product({
    this.id,
    this.title,
    this.brand,
    this.categories,
    this.slug,
    this.metaDescription,
    this.description,
    this.photos,
    this.colors,
    this.sizes,
    this.tags,
    this.regularPrice,
    this.currentPrice,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      brand: json['brand'] is Map<String, dynamic>
          ? Brand.fromJson(json['brand'])
          : null,
      categories: json['categories'] != null
          ? (json['categories'].isNotEmpty && json['categories'][0] is Map)
              ? List<Category>.from(
                  json['categories'].map((v) => Category.fromJson(v)))
              : List<Category>.from(
                  json['categories'].map((v) => Category(id: v)))
          : [],
      slug: json['slug'],
      metaDescription: json['meta_description'],
      description: json['description'],
      photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : [],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      regularPrice: json['regular_price'],
      currentPrice: json['current_price'],
      quantity: json['quantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
