import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:t_store/features/shop/controllers/product/image_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            //Main Large Image
            SizedBox(
                height: 350.0,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargeImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          color: TColors.primary,
                          value: downloadProgress.progress,
                        ),
                      ),
                    );
                  })),
                )),
            Positioned(
                right: 0,
                bottom: 30,
                left: 0,
                child: SizedBox(
                  height: 80.0,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.spaceBtwItems,
                    ),
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    itemBuilder: (_, index) {
                      return Obx(() {
                        final imageSelected =
                            controller.selectedProductImage.value ==
                                images[index];
                        return TRoundedImage(
                          isNetworkImage: true,
                          imageUrl: images[index],
                          width: 80.0,
                          backgroundColor: dark ? TColors.dark : TColors.white,
                          onPressed: () => controller
                              .selectedProductImage.value = images[index],
                          border: Border.all(
                              color: (imageSelected)
                                  ? TColors.primary
                                  : Colors.transparent),
                          padding: const EdgeInsets.all(TSizes.sm),
                        );
                      });
                    },
                  ),
                )),
            TAppBar(
              showBackArrow: true,
              actions: [
                TFavouriteIcon(
                  productId: product.id,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
