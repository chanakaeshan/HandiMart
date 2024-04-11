import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/data/services/firebase_storage_service.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  //Variables
  final _db = FirebaseFirestore.instance;

  //Getall Products
  Future<List<ProductModel>> getFeaturedProducts({int limit = 4}) async {
    try {
      final snapshot = (limit == -1)
          ? await _db
              .collection("Products")
              .where("IsFeatured", isEqualTo: true)
              .get()
          : await _db
              .collection("Products")
              .where("IsFeatured", isEqualTo: true)
              .limit(4)
              .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //Getall Products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where("IsFeatured", isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<List<ProductModel>> getAllSellerProducts({required String owner}) async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where("Owner", isEqualTo: owner)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //Getall Products
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productsList = querySnapshot.docs
          .map((e) => ProductModel.fromQuerySnapshot(e))
          .toList();

      return productsList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = (limit == -1)
          ? await _db
              .collection("Products")
              .where("Brand.Id", isEqualTo: brandId)
              .get()
          : await _db
              .collection("Products")
              .where("Brand.Id", isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      QuerySnapshot productsCategoryQuery = (limit == -1)
          ? await _db
              .collection("ProductCategory")
              .where("categoryId", isEqualTo: categoryId)
              .get()
          : await _db
              .collection("ProductCategory")
              .where("categoryId", isEqualTo: categoryId)
              .limit(limit)
              .get();
      List<String> productIds = productsCategoryQuery.docs
          .map((doc) => doc["productId"] as String)
          .toList();
      if (productIds.isEmpty) {
        return [];
      }
      final productsQuery = await _db
          .collection("Products")
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Upload Products to Cloud firestore
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Uploading Your Data...", TImages.cloudUploadingAimation);
      //Upload all categoryalong with their images
      final storage = Get.put(TFirebaseStorageService());

      for (var product in products) {
        //Get image data lin from loacalassets
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);

        //Uploadimage and get its url
        final url = await storage.uploadImageData(
            "Products/Images", thumbnail, product.thumbnail.toString());

        //assing url tocategory image attribute
        product.thumbnail = url;

        //Product list  ofimages
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];

          for (var image in product.images!) {
            final assetImage = await storage.getImageDataFromAssets(image);

            final url = await storage.uploadImageData(
                "Products/Images", assetImage, image);

            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }
        //Upload variationimages
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            final url = await storage.uploadImageData(
                "Products/Images", assetImage, variation.image);

            variation.image = url;
          }
        }

        //Store Categoryin Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
      TFullScreenLoader.stopLoading();
      TLoaders.succcesSnackBar(
          title: "Products Uploaded",
          message: "The products data has been successfully uploaded");
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went wrong. Please try again";
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadingProduct(List<ProductModel> products) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        "Uploading Your Data...", TImages.cloudUploadingAimation);
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        //Upload Image
        final imageUrl =
            await userRepository.uploadImage("Products/Images/", image);

        

        TLoaders.succcesSnackBar(
            title: "Image Uploaded",
            message: "Product image has been updated wait for until data save"
        );
        for (var product in products) {
          product.thumbnail = imageUrl;

          product.images?.clear();
          product.images?.add(imageUrl);
        }
        
      }
      //Upload all categoryalong with their images
      //final storage = Get.put(TFirebaseStorageService());

      for (var product in products) {
        //Get image data lin from loacalassets
        //final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        //Uploadimage and get its url
        /*if (image != null) {
          final url = await uploadImage("Products/Images/", image);
          product.thumbnail = url;
        }*/
        

        //assing url tocategory image attribute
        

        //Product list  ofimages
        /*if (product.images != null && product.images!.isNotEmpty && image != null) {
          List<String> imageUrl = [];

          for (var img in product.images!) {
            //final assetImage = await storage.getImageDataFromAssets(image);

            final url = await uploadImage("Products/Images/", image);

            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }*/
        //Upload variationimages
        /*if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            //final assetImage =
                //await storage.getImageDataFromAssets(variation.image);

            //final url = await storage.uploadImageData(
               // "Products/Images", assetImage, variation.image);

            //variation.image = url;
          }
        }*/

        //Store Categoryin Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
      TFullScreenLoader.stopLoading();
      TLoaders.succcesSnackBar(
          title: "Products Data Uploaded",
          message: "The products data has been successfully uploaded");
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went wrong. Please try again";
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  

  Future<String> uploadImage(String path, XFile? image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image!.name);
      await ref.putFile(File(image!.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went wrong. Please try again";
    }
  }

  Future<String> uploadProductImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image!.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went wrong. Please try again";
    }
  }
  

  Future<String> uploadImageFile(String path, File? image) async {
    try {
      if (image == null || !image.existsSync()) {
        throw Exception("Invalid image file");
      }

      final ref = FirebaseStorage.instance.ref(path).child(image.path.split('/').last);
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

}
