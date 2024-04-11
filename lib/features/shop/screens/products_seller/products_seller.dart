import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/features/shop/screens/products_seller/my_product.dart';
import 'package:t_store/features/shop/screens/products_seller/product_adding.dart';
import 'package:t_store/features/shop/screens/products_seller/widgets/seller_home_appbar.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SellerHome extends StatelessWidget {
  const SellerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Center(
            child: Column(
              children: [
                const TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      SellerHomeAppBar(),
                      SizedBox(
                        height: TSizes.spaceBtwItems*2.5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TSettingMenuTile(
                        onTap: () => Get.to(() => const ProductAdding()),
                        icon: Iconsax.box_add,
                        title: "Add New Product",
                        subtitle: "List your product by adding details",
                      ),

                      TSettingMenuTile(
                        onTap: () => Get.to(() => const MyProductsSeller()),
                        icon: Iconsax.box,
                        title: "View All Products",
                        subtitle: "See your all listed products",
                      ),
                    ],
                  ),
                ),
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
