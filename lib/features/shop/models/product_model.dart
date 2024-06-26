// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_attribute_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  String owner;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.owner,
    required this.productType,
    this.salePrice = 0.0,
    this.sku,
    this.date,
    this.brand,
    this.description,
    this.isFeatured,
    this.categoryId,
    this.images,
    this.productAttributes,
    this.productVariations,
  });
  static ProductModel empty() => ProductModel(
        id: "",
        stock: 0,
        price: 0,
        title: "",
        thumbnail: "",
        owner: "",
        productType: "",
      );

  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'Owner': owner,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'date': date?.millisecondsSinceEpoch,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return ProductModel.empty();
    }
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data["Title"],
      sku: data["SKU"],
      stock: data['Stock'] ?? 0,
      isFeatured: data["IsFeatured"] ?? false,
      price: double.parse((data["Price"] ?? 0.0).toString()),
      salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
      thumbnail: data["Thumbnail"] ?? "",
      owner: data["Owner"] ?? "",
      categoryId: data["CategoryId"] ?? "",
      description: data["Description"] ?? "",
      productType: data["ProductType"] ?? "",
      brand: BrandModel.fromJson(data["Brand"]),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      productAttributes: (data["ProductAttributes"] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data["ProductVariations"] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data["Title"] ?? "",
      sku: data["SKU"] ?? "",
      stock: data['Stock'] ?? 0,
      isFeatured: data["IsFeatured"] ?? false,
      price: double.parse((data["Price"] ?? 0.0).toString()),
      salePrice: double.parse((data["SalePrice"] ?? 0.0).toString()),
      thumbnail: data["Thumbnail"] ?? "",
      owner: data["Owner"] ?? "",
      categoryId: data["CategoryId"] ?? "",
      description: data["Description"] ?? "",
      productType: data["ProductType"] ?? "",
      brand: BrandModel.fromJson(data["Brand"]),
      images: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      productAttributes: (data["ProductAttributes"] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data["ProductVariations"] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
