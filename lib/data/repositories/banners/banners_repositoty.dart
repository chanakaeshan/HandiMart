import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/services/firebase_storage_service.dart';
import 'package:t_store/features/shop/models/banner_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //Variables
  final _db = FirebaseFirestore.instance;

  //Getall banners
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection("Banners")
          .where("Active", isEqualTo: true)
          .get();
      final list = result.docs
          .map((document) => BannerModel.fromSnaphot(document))
          .toList();
      return list;
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

  // Upload Categories to Cloud firestore
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Uploading Your Data...", TImages.cloudUploadingAimation);
      //Upload all categoryalong with their images
      final storage = Get.put(TFirebaseStorageService());

      for (var banner in banners) {
        //Get image data lin from loacalassets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        //Upload image and get its url
        final url =
            await storage.uploadImageData("Banners", file, banner.targetScreen);

        //assing url to banner image attribute
        banner.imageUrl = url;

        //Store banner Firestore
        await _db
            .collection("Banners")
            .doc(banner.targetScreen)
            .set(banner.toJson());
      }
      TFullScreenLoader.stopLoading();
      TLoaders.succcesSnackBar(
          title: "Banners Uploaded",
          message: "The banners data has been successfully uploaded");
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
