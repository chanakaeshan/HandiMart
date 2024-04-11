import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/features/shop/controllers/product/favourites_controller.dart';
import 'package:t_store/utils/constants/colors.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final favouritesController = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        onPressed: () => favouritesController.toggleFavouriteProduct(productId),
        icon: favouritesController.isFavourite(productId)
            ? Iconsax.heart5
            : Iconsax.heart,
        color:
            favouritesController.isFavourite(productId) ? TColors.error : null,
      ),
    );
  }
}
