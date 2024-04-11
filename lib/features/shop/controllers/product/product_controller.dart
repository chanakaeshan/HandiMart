import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/products_seller/my_product.dart';
import 'package:t_store/features/shop/screens/products_seller/products_seller.dart';
import 'package:t_store/navigation_menu_seller.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final userController = UserController.instance;

  //Variables
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> sellerProducts = <ProductModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
    fetchSellerProducts();
  }

  //Load Fetured products Data
  Future<void> fetchFeaturedProducts() async {
    try {
      //Loading
      isLoading.value = true;

      //fetch categories from data source
      final products = await _productRepository.getFeaturedProducts(limit: -1);
      //Assign products
      featuredProducts.assignAll(products);

      //Filter featured categories
    } catch (e) {
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      //Remove Loader
      isLoading.value = false;
    }
  }

  Future<void> fetchSellerProducts() async {
    try {
      //Loading
      isLoading.value = true;

      //fetch categories from data source
      final products = await _productRepository.getAllSellerProducts(owner: userController.user.value.id.toString());
      //Assign products
      sellerProducts.assignAll(products);

      //Filter featured categories
    } catch (e) {
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      //Remove Loader
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      //fetch categories from data source
      final products = await _productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }
  }

  //Get the product price or price range of variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    //ifno variation existreturn thesimple priceorsale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      //calculate the smallest and largestprice among variations
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //Update smallest and largest price
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      //if smallest andlargest price are the same return single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return "$smallestPrice - \$$largestPrice";
      }
    }
  }

  //Calculate discount
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  //Check product stockstatus
  String getProductStockStatus(int stock) {
    return stock > 0 ? "In Stock" : "Out of Stock";
  }

  void deleteProductWarningPopUp(id) {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: TSizes.defaultSpace),
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: "Delete Product $id",
        middleText:
            "Are you sure you want to delete this product permanently? This action is not reversible and all of the product's data will be removed permanently",
        confirm: ElevatedButton(
            onPressed: () async => deleteProduct(id),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.5, vertical: 12.5),
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: Text(
              "Delete",
              style: Theme.of(Get.overlayContext!)
                  .textTheme
                  .titleMedium!
                  .apply(color: Colors.white),
            )),
        cancel: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.5, vertical: 12.5),
            ),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text(
              "Cancel",
              style: Theme.of(Get.overlayContext!).textTheme.titleMedium!,
            )));
  }

  void deleteProduct(id) async {
    try {
      TFullScreenLoader.openLoadingDialog( "Processing", TImages.doccerAnimation);

      await FirebaseFirestore.instance.collection("Products").doc(id).delete();
      TLoaders.succcesSnackBar(title: "Success!", message:"Product with ID $id deleted successfully");

      TFullScreenLoader.stopLoading();
      Get.to(() => const NavigationMenuSeller());
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
