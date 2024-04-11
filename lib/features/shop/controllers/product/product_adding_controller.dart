import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/dummy_data.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';
import 'package:uuid/uuid.dart';

class ProductAddingController extends GetxController {
  static ProductAddingController get instance => Get.find();
  final userController = UserController.instance;

  final title = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  final salePrice = TextEditingController();
  final stock = TextEditingController();
  GlobalKey<FormState> productAddingFormKey = GlobalKey<FormState>();

  final imageUploading = false.obs;
  final userRepository = Get.put(UserRepository());

  List<ProductModel> productList = [];

  final productRepository = Get.put(ProductRepository());

  void addProduct() async {
    if (productAddingFormKey.currentState!.validate()) {
      // Validation passed, create a new ProductModel instance
      ProductModel product = ProductModel(
        id: "${userController.user.value.id}_${"test"}",
        stock: int.parse(stock.text),
        price: double.parse(price.text),
        title: title.text,
        isFeatured: true,
        thumbnail: "", 
        owner: userController.user.value.id.toString(),
        description: description.text,
        brand: BrandModel(
          id: "6",
          image: TImages.pumaLogo,
          name: "null",
          productsCount: int.parse(stock.text),
          isFeatured: true
        ),
        images: [
          "", 
        ],
        salePrice: double.parse(salePrice.text),
        sku: "GHt8942",
        categoryId: category.text,
        productType: ProductType.single.toString(),
      );
      
      final List<ProductModel> products = [
        ProductModel(
          id: "${userController.user.value.id}_${generateRandomId()}",
          stock: int.parse(stock.text),
          price: double.parse(price.text),
          title: title.text,
          isFeatured: true,
          thumbnail: "", 
          owner: userController.user.value.id.toString(),
          description: description.text,
          brand: BrandModel(
            id: "6",
            image: TImages.pumaLogo,
            name: "null",
            productsCount: int.parse(stock.text),
            isFeatured: true
          ),
          images: [
            "", 
          ],
          salePrice: double.parse(salePrice.text),
          sku: "GHt8942",
          categoryId: category.text,
          productType: ProductType.single.toString(),
        ),
      ];

      productList.add(product);
      //productRepository.uploadingProduct(TDummyData.products);
      productRepository.uploadingProduct(products);
    } else {
      TLoaders.errorSnackBar(title: "Oh Snap!", message:{"product not save"});
    }

    
  }

  String generateRandomId() {
    const uuid = Uuid();
    return uuid.v4();
  }

  getUploadedImageLink() async {
    try {
      imageUploading.value = true;
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
            title: "Congratulations",
            message: "Your profile image has been updated"
        );

        return imageUrl;
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Oh Snap!", message: "Something went wrong: $e");
    } finally {
      imageUploading.value = false;
    }
  }
  
}