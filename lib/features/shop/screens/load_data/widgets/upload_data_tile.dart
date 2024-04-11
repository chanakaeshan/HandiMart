import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TUploadDataTile extends StatelessWidget {
  const TUploadDataTile({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 5, vertical: TSizes.spaceBtwItems),
        child: Row(
          children: [
            Icon(
              icon,
              size: TSizes.iconLg,
              color: TColors.primary,
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )),
            const Icon(
              Iconsax.arrow_circle_up3,
              size: TSizes.iconLg,
              color: TColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
