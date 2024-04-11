import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  //Variables
  RxString selectedProductImage = "".obs;

  //Get allimages form prodcut variations
  List<String> getAllProductImages(ProductModel product) {
    //toadd unique image sonly
    Set<String> images = {};

    selectedProductImage.value = product.thumbnail;

    //!!!!!!!!!!!!This adds extra images too
    // images.add(product.thumbnail);
    // if (product.images != null) {
    //   images.addAll(product.images!);
    // }
    // if (product.productVariations != null ||
    //     product.productVariations!.isNotEmpty) {
    //   images.addAll(
    //       product.productVariations!.map((variation) => variation.image));
    // }

    if (product.productType == ProductType.single.toString()) {
      if (product.images != null) {
        images.addAll(product.images!);
      }
    } else {
      if (product.productVariations != null ||
          product.productVariations!.isNotEmpty) {
        images.addAll(
            product.productVariations!.map((variation) => variation.image));
      }
    }
    return images.toList();
  }

  //ShowImage Popup
  void showEnlargeImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.defaultSpace * 2,
                        horizontal: TSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150.0,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "Close",
                            style: Theme.of(Get.context!).textTheme.titleMedium,
                          )),
                    ),
                  )
                ],
              ),
            ));
  }
}
