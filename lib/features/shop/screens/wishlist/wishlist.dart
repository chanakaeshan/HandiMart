import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/loaders/animation_loader.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/features/shop/controllers/product/favourites_controller.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteController = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            Obx(
              () => FutureBuilder(
                  future: favouriteController.favouriteProducts(),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer(
                      itemCount: 6,
                    );
                    final emptyWidget = TAnimationLoaderWidget(
                      text: "Whoops! Wishlist is Empty...",
                      animation: TImages.pencilAnimation,
                      showAction: true,
                      actionText: "Let's add some",
                      onActionPressed: () {
                        NavigationController.instance.selectedIndex.value = 0;
                      },
                    );

                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget);
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return TGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                              product: products[index],
                            ));
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
