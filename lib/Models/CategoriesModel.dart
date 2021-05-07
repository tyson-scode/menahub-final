// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.id,
    this.parentId,
    this.name,
    this.isActive,
    this.position,
    this.level,
    this.productCount,
    this.childrenData,
  });

  int id;
  int parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<CategoriesModel> childrenData;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        isActive: json["is_active"],
        position: json["position"],
        level: json["level"],
        productCount: json["product_count"],
        childrenData: List<CategoriesModel>.from(
            json["children_data"].map((x) => CategoriesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "is_active": isActive,
        "position": position,
        "level": level,
        "product_count": productCount,
        "children_data":
            List<dynamic>.from(childrenData.map((x) => x.toJson())),
      };
}
