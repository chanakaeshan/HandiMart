import 'package:flutter/material.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/pricing_text.dart';
import 'package:t_store/utils/helpers/pricing_calculator.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        TRowPricingText(
          title: "SubTotal",
          value: "\$$subTotal",
          valuTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        TRowPricingText(
          title: "Shipping Fee",
          value:
              "\$${TPricingCalculator.calculateShippingCost(subTotal, "US")}",
        ),
        TRowPricingText(
          title: "Tax Fee",
          value: "\$${TPricingCalculator.calculateTax(subTotal, "US")}",
        ),
        TRowPricingText(
          title: "Order Total",
          value: "\$${TPricingCalculator.calculateTotalPrice(subTotal, "US")}",
          valuTextStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
