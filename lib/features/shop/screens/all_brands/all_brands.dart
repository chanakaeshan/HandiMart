import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/shimmers/brands_shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/brand_controller.dart';
import 'package:t_store/features/shop/screens/all_brands/brand_products.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Brand",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace, vertical: TSizes.spaceBtwItems),
          child: Column(
            children: [
              const TSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(() {
                if (brandController.isLoading.value) {
                  return const TBrandsShimmer();
                }
                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                  );
                } else {
                  return TGridLayout(
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 70.0,
                      itemBuilder: (_, index) {
                        return TBrandCard(
                          onTap: () => Get.to(TBrandProducts(
                            brand: brandController.allBrands[index],
                          )),
                          showBorder: true,
                          fit: BoxFit.contain,
                          brand: brandController.allBrands[index],
                          // onTap: () {},
                        );
                      });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
