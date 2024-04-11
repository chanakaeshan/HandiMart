import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        Image(
          height: 150.0,
          image: AssetImage(
            dark ? TImages.lightAppLogo : TImages.darkAppLogo,
          ),
        ),
        const SizedBox(
          height: TSizes.lg,
        ),
        Text(
          currentLanguage == 'sinhala' ? 'පූරණය වන්න' : 'Welcome Back',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          currentLanguage == 'sinhala' ? TTexts.loginSubTitleSinhala : TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
