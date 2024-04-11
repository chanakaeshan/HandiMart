import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/repositories/banners/banners_repositoty.dart';
import 'package:t_store/data/repositories/brand/brand_repository.dart';
import 'package:t_store/data/repositories/category/category_repository.dart';
import 'package:t_store/data/repositories/dummy_data.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/data/repositories/sub_record/sub_record_repository.dart';
import 'package:t_store/features/shop/screens/load_data/widgets/upload_data_tile.dart';
import 'package:t_store/utils/constants/sizes.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryRepository = Get.put(CategoryRepository());
    final bannerRepository = Get.put(BannerRepository());
    final productRepository = Get.put(ProductRepository());
    final brandRepository = Get.put(BrandRepository());
    final subRecordRepository = Get.put(SubRecordRepository());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Upload Data",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace, vertical: TSizes.md),
          child: Column(
            children: [
              const TSectionHeading(
                title: "Main Record",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TUploadDataTile(
                text: "Upload Categories",
                icon: Iconsax.box,
                onTap: () =>
                    categoryRepository.uploadDummyData(TDummyData.categories),
              ),
              TUploadDataTile(
                text: "Upload Banners",
                icon: Iconsax.shop,
                onTap: () =>
                    bannerRepository.uploadDummyData(TDummyData.banners),
              ),
              TUploadDataTile(
                text: "Upload Products",
                icon: Iconsax.shopping_bag,
                onTap: () =>
                    productRepository.uploadDummyData(TDummyData.products),
              ),
              TUploadDataTile(
                text: "Upload Brands",
                icon: Iconsax.gallery,
                onTap: () => brandRepository.uploadDummyData(TDummyData.brands),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSectionHeading(
                title: "Sub Record",
                showActionButton: false,
              ),
              const Text(
                  "Make sure you have already uploaded the content above"),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TUploadDataTile(
                text: "Upload Brands & Categories Relation Data",
                icon: Iconsax.link,
                onTap: () => subRecordRepository
                    .uploadBrandCategoryDummyData(TDummyData.brandCategorys),
              ),
              TUploadDataTile(
                text: "Upload Product Categories Relation Data",
                icon: Iconsax.link,
                onTap: () => subRecordRepository.uploadProductCategoryDummyData(
                    TDummyData.productCategorys),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
