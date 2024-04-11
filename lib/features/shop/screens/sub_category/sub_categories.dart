import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_horizontal.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              const TRoundedImage(
                imageUrl: TImages.promoBanner1,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //SubCategories
              FutureBuilder(
                  future: categoryController.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();

                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                    );
                    if (widget != null) return widget;

                    final subCategories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subCategories.length,
                        itemBuilder: (context, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder(
                              future: categoryController.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                final widget =
                                    TCloudHelperFunctions.checkMultiRecordState(
                                  snapshot: snapshot,
                                  loader: loader,
                                  // returnWidgetInt: 0,
                                );
                                if (widget != null) return widget;

                                final products = snapshot.data!;
                                return Column(
                                  children: [
                                    TSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () =>
                                          Get.to(() => AllProductsScreen(
                                                title: subCategory.name,
                                                futureMethod: categoryController
                                                    .getCategoryProducts(
                                                        categoryId:
                                                            subCategory.id,
                                                        limit: -1),
                                              )),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwItems / 2,
                                    ),
                                    SizedBox(
                                      height: 120.0,
                                      child: ListView.separated(
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(
                                                width: TSizes.spaceBtwItems,
                                              ),
                                          itemBuilder: (context, index) {
                                            return TProductCardHorizontal(
                                              product: products[index],
                                            );
                                          }),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwSections / 2,
                                    ),
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
