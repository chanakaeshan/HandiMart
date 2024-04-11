import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/product_details.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TProductCardAddToCartButton extends StatelessWidget {
  const TProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        //ifthe product have variations then show the productdetailsforthe variatio selection
        //Else add product tothe cart
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            buttonWidget(productQuantityInCart > 0),
            if (productQuantityInCart > 0)
              Positioned(
                top: -10,
                left: -10,
                child: Container(
                  padding: const EdgeInsets.all(7.5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: TColors.dark),
                  child: Center(
                    child: Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

Widget buttonWidget(bool isProductAdded) {
  return Container(
    decoration: BoxDecoration(
        color: isProductAdded ? TColors.primary : TColors.dark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusMd),
          bottomRight: Radius.circular(TSizes.productImageRadius),
        )),
    child: const SizedBox(
      height: TSizes.iconLg * 1.2,
      width: TSizes.iconLg * 1.2,
      child: Center(
        child: Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
    ),
  );
}
