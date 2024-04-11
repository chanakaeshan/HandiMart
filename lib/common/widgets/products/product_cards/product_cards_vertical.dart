import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/styles/shadows.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:t_store/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:t_store/common/widgets/texts/brand_title_text_with_verifiacion_icon.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/product_details.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: Container(
        width: 180.0,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkerGrey : TColors.white),
        child: Column(children: [
          //Thumbnail ,Wishlist discount tag
          TRoundedContainer(
            height: 160.0,
            width: 180.0,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                //ThumbnailImage
                Center(
                  child: TRoundedImage(
                    width: double.infinity,
                    imageUrl: product.thumbnail,
                    isNetworkImage: true,
                    applyImageRadius: true,
                  ),
                ),
                //Sale Tag
                if (salePercentage != null)
                  Positioned(
                      top: 12.0,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          "$salePercentage%",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      )),
                //Favorite Icon
                Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: TFavouriteIcon(
                      productId: product.id,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          )
          //Details
          ,
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm, right: TSizes.sm),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TProductTitleText(
                title: product.title,
                smallSize: true,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TBrandTitleTextWithVerificationIcon(
                title: product.brand!.name,
                textAlign: TextAlign.start,
              ),
            ]),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Price
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.productType == ProductType.single.toString() &&
                        product.salePrice > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: TSizes.sm),
                        child: Text(
                          "\$${product.price}",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: TProductPriceText(
                        price: controller.getProductPrice(product),
                      ),
                    ),
                  ],
                ),
              ),
              TProductCardAddToCartButton(
                product: product,
              )
            ],
          )
        ]),
      ),
    );
  }
}
