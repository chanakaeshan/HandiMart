import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/features/shop/models/brand_category_model.dart';
import 'package:t_store/features/shop/models/product_category_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';

class SubRecordRepository extends GetxController {
  static SubRecordRepository get instance => Get.find();

  //Variables
  final _db = FirebaseFirestore.instance;

  // Upload Brands to Cloud firestore
  Future<void> uploadBrandCategoryDummyData(
      List<BrandCategoryModel> brandCategorys) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Uploading Your Data...", TImages.cloudUploadingAimation);
      //Upload all categoryalong with their images

      for (var brandCategory in brandCategorys) {
        //Store banner Firestore
        await _db.collection("BrandCategory").doc().set(brandCategory.toJson());
      }
      TFullScreenLoader.stopLoading();
      TLoaders.succcesSnackBar(
          title: "BrandCategory Uploaded",
          message: "The brand category data has been successfully uploaded");
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

  Future<void> uploadProductCategoryDummyData(
      List<ProductCategoryModel> productCategorys) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Uploading Your Data...", TImages.cloudUploadingAimation);
      //Upload all categoryalong with their images

      for (var productCategory in productCategorys) {
        //Store banner Firestore
        await _db
            .collection("ProductCategory")
            .doc()
            .set(productCategory.toJson());
      }
      TFullScreenLoader.stopLoading();
      TLoaders.succcesSnackBar(
          title: "ProductCategory Uploaded",
          message: "The product category data has been successfully uploaded");
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
}
