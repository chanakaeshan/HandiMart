import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/loaders/animation_loader.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_brands.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Brands

                TCategoryBrands(
                  category: category,
                ),

                //Prdoducts
                FutureBuilder(
                    future: categoryController.getCategoryProducts(
                        categoryId: category.id),
                    builder: (context, snapshot) {
                      final emptyWidget = TAnimationLoaderWidget(
                        text: "Whoops! ${category.name} is Empty...",
                        animation: TImages.pencilAnimation,
                        showAction: false,
                      );
                      final widget =
                          TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: const TVerticalProductShimmer(),
                              nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;

                      return Column(
                        children: [
                          TSectionHeading(
                            title: "You might like",
                            onPressed: () => Get.to(AllProductsScreen(
                              title: category.name,
                              futureMethod:
                                  categoryController.getCategoryProducts(
                                      categoryId: category.id, limit: -1),
                            )),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          TGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) => TProductCardVertical(
                                    product: products[index],
                                  )),
                        ],
                      );
                    })
              ],
            ),
          ),
        ]);
  }
}
