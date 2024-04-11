import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/rating/rating_indicator.dart';
import 'package:t_store/features/shop/screens/product_reviews/widgets/overall_progress_rating.dart';
import 'package:t_store/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "Reviews & Ratings",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
                "Ratings and reviews are verified and are from people who use the same type of device you use."),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            //Overall Product Ratings
            const TOverallProductsRating(),
            const TRatingBarIndicator(
              rating: 3.5,
            ),
            Text(
              "12,611",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //User Review List
            const TUserReviewCard(), const TUserReviewCard(), const TUserReviewCard(),
          ]),
        ),
      ),
    );
  }
}
