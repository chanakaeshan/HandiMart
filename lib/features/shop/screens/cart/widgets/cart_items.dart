import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/products/cart/add_remove_button.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });
  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.only(top: 15.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) {
          return Obx(() {
            final item = controller.cartItems[index];
            return Column(
              children: [
                //Cart Item
                TCartItem(
                  cartItem: item,
                ),
                // Whether to show the add remove button ornot
                if (showAddRemoveButton) ...[
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  //Add Remove Buton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 70.0,
                          ),
                          TProductQuantityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () => controller.addOneToCart(item),
                            remove: () => controller.removeOneFromCrt(item),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: TProductPriceText(
                              price: (item.price * item.quantity)
                                  .toStringAsFixed(1)))
                    ],
                  ),
                ]
              ],
            );
          });
        },
      ),
    );
  }
}
