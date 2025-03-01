import 'package:sum_app/features/home/data/models/bannar_model.dart';

class ProductDetailsModel {
  String? msg;
  List<BannarModel>? bannarList;

  ProductDetailsModel({this.msg, this.bannarList});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      bannarList = <BannarModel>[];
      json['data'].forEach((v) {
        bannarList!.add(BannarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (bannarList != null) {
      data['data'] = bannarList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
