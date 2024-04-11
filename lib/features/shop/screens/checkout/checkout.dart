import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/common/widgets/products/cart/coupon_code.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/order_controller.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/helpers/pricing_calculator.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, "US");
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.md),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => TLoaders.warningSnackBar(
                  title: "Empty Cart",
                  message: "Add Items in thecart in order to proceed"),
          child: Text(
            "Checkout \$$totalAmount",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          //Cart Items
          child: Column(
            children: [
              //Items in Cart
              const TCartItems(
                showAddRemoveButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Coupon Text Field
              const TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //BillingSection
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(children: [
                  //Pricing
                  TBillingAmountSection(),

                  //Divider
                  Divider(),

                  //Payment Mthods
                  TBillingPaymentSection(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  //Address
                  TBillingAddressSection(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
