import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/loaders/animation_loader.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/checkout.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  get itemBuilder => null;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: "Whoops! Cart is Empty...",
          animation: TImages.pencilAnimation,
          showAction: true,
          actionText: "Let's fill it",
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        return (controller.cartItems.isEmpty)
            ? emptyWidget
            : const SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  //Cart Items
                  child: TCartItems(),
                ),
              );
      }),
      bottomNavigationBar: (controller.cartItems.isEmpty)
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.md),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckOutScreen()),
                child: Obx(
                  () => Text(
                    "Checkout \$${controller.totalCartPrice.value}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: Colors.white),
                  ),
                ),
              ),
            ),
    );
  }
}
