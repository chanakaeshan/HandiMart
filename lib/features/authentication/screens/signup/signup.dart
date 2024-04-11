import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/common/widgets/login_signup/form_divider.dart';
import 'package:t_store/common/widgets/login_signup/social_buttons.dart';
import 'package:t_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(
                currentLanguage == 'sinhala' ? 'නව ගිණුමක් සාදන්න' : TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //Form
              const TSignUpForm(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              //Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              //SocialButtons
              const TSocialButtons(),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                    Get.to(() => const OnBoardingScreen());
                  },
                  child: Text(
                    currentLanguage == 'sinhala' ? 'Seller සහ Buyer අතර මාරු වීමට අවශ්‍යද?' : "Do you want to change buyer or selle?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: TColors.primary),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
