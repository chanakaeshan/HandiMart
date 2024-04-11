import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRowPricingText extends StatelessWidget {
  const TRowPricingText({
    super.key,
    required this.title,
    required this.value,
    this.valuTextStyle,
  });
  final String title, value;
  final TextStyle? valuTextStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: TSizes.spaceBtwItems / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(value,
              style: valuTextStyle ?? Theme.of(context).textTheme.labelLarge)
        ],
      ),
    );
  }
}
