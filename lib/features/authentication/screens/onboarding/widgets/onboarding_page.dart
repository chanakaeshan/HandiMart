import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    /*return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: THelperFunctions.screenWidth() * 0.8,
            height: THelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );*/
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: THelperFunctions.screenWidth() * 0.7,
            height: THelperFunctions.screenHeight() * 0.5,
            image: AssetImage(image),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          title == "Choose your favourite handmade product"
            ? Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
              
              : title == "Select a language"
                  ? Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => {OnBoardingController.instance.toBuyerOrSeller("english")},
                            style: ElevatedButton.styleFrom(padding: const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20)),
                            child: const Text("English"),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          ElevatedButton(
                            onPressed: () => {OnBoardingController.instance.toBuyerOrSeller("sinhala")},
                            style: ElevatedButton.styleFrom(padding: const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20)),
                            child: const Text("Sinhala"),
                          )
                        ],
                      )
                    ],
                  )
                  : Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => {OnBoardingController.instance.toLoginPage("buyer")},
                            style: ElevatedButton.styleFrom(padding: const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20)),
                            child: const Text("Buyer"),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          ElevatedButton(
                            onPressed: () => {OnBoardingController.instance.toLoginPage("seller")},
                            style: ElevatedButton.styleFrom(padding: const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20)),
                            child: const Text("Seller"),
                          )
                        ],
                      )
                    ],
                  ),
          const SizedBox(height: TSizes.spaceBtwItems),
          
        ],
      ),
    );
  }
}
