import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/features/shop/screens/products_seller/my_product.dart';
import 'package:t_store/features/shop/screens/products_seller/widgets/product_adding_form.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductAdding extends StatelessWidget {
  const ProductAdding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Listing Product",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.box,
            onPressed: () =>
                Get.to(const MyProductsSeller()),
          )
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHieght,
          child: Column(
            children: [
              
              //Form
              TProductAddingForm()
            ],
          ),
        ),
      ),
    );
  }
}
