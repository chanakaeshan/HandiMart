// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = "",
    required this.isFeatured,
  });
  //Empty helper function
  static CategoryModel empty() => CategoryModel(
        id: "",
        name: "",
        image: "",
        isFeatured: false,
      );
  //Convert model tojson
  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Image": image,
      "ParentId": parentId,
      "IsFeatured": isFeatured,
    };
  }

  //Map json oriented document snapshot from firebase to model
  factory CategoryModel.fromSnaphot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data["Name"] ?? "",
        image: data["Image"] ?? "",
        isFeatured: data["IsFeatured"] ?? false,
        parentId: data["ParentId"] ?? "",
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
