import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/shimmers/shimmer.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          TTexts.homeAppbarTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.grey),
        ),
        Obx(() {
          if (controller.profileLoading.value) {
            //Display a shimmer loader wile profile ferching data
            return const TShimmerEffect(height: 15.0, width: 80.0);
          } else {
            return Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            );
          }
        })
      ]),
      actions: [
        TCartCounterIcon(
          iconColor: Colors.white,
          onPressed: () => Get.to(() => const CartScreen()),
        )
      ],
    );
  }
}
