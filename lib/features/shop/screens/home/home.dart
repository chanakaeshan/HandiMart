import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widget/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widget/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widget/promo_slider.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //App Bar
                  THomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  //SearchBar
                  TSearchContainer(
                    text: "Search in Store",
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //Categories
                  Column(
                    children: [
                      //Heading
                      Padding(
                        padding: EdgeInsets.only(left: TSizes.defaultSpace),
                        child: TSectionHeading(
                          title: "Popular Categories",
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      //Categories
                      THomeCategories(),
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            //Body
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  children: [
                    //Promo Slider
                    const TPromoSlider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Heading
                    TSectionHeading(
                      title: "Popular Products",
                      onPressed: () => Get.to(() => AllProductsScreen(
                            title: "Popular Products",
                            query: FirebaseFirestore.instance
                                .collection("Products")
                                .where("IsFeatured", isEqualTo: true)
                                .limit(6),
                            futureMethod: controller.fetchAllFeaturedProducts(),
                          )),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    //Products GridView
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TVerticalProductShimmer();
                      }
                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            "No Data Found",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(color: Colors.white),
                          ),
                        );
                      }
                      return TGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      );
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
