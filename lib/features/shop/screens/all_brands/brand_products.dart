import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/brand_controller.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class TBrandProducts extends StatelessWidget {
  const TBrandProducts({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          brand.name,
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
              title: "All Products",
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Row(
              children: [
                SizedBox(
                  width: TDeviceUtils.getScreenWidth(context) * 0.5,
                  child: TBrandCard(
                      brand: brand, fit: BoxFit.contain, showBorder: true),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            FutureBuilder(
                future: brandController.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  //Check the state of future builder snapshot
                  const loader = TVerticalProductShimmer();

                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return TSortableProducts(
                    products: brandProducts,
                  );
                })
          ],
        ),
      )),
    );
  }
}
