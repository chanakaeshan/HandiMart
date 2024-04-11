import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/screens/products_seller/product_adding.dart';
import 'package:t_store/features/shop/screens/products_seller/widgets/my_product_cards_vertical.dart';

class MyProductsSeller extends StatelessWidget {
  const MyProductsSeller({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "My Listed Products",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.box_add,
            onPressed: () =>
                Get.to(const ProductAdding()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const TVerticalProductShimmer();
                }
                if (controller.sellerProducts.isEmpty) {
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
                  itemCount: controller.sellerProducts.length,
                  itemBuilder: (_, index) => SellerProductCardVertical(
                    product: controller.sellerProducts[index],
                  ),
                );
              }),
            ],
          )
          
           
        )
      )
    );
  }
}