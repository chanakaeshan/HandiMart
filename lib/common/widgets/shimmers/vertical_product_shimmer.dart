import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/shimmers/shimmer.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Image
                    TShimmerEffect(
                      width: 180.0,
                      height: 180.0,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //Text
                    TShimmerEffect(
                      width: 160.0,
                      height: 15.0,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TShimmerEffect(
                      width: 110.0,
                      height: 15.0,
                    ),
                  ]),
            ));
  }
}
