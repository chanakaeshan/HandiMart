import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductAddingHeader extends StatelessWidget {
  const TProductAddingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(
          "List a Product",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        
      ],
    );
  }
}
