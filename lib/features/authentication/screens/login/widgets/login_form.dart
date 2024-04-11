import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:t_store/features/authentication/screens/signup/signup.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/validators/validation.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(children: [
          //Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: currentLanguage == 'sinhala' ? 'ඊ-ලිපිනය' : 'Email'),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //Password
          Obx(
            () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                  labelText: currentLanguage == 'sinhala' ? 'මුරපදය' : 'Password',
                  prefixIcon: const Icon(Iconsax.user_edit),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: controller.hidePassword.value
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye))),
            ),
          ),
          //Remember me andforgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value),
                  ),
                  Text(currentLanguage == 'sinhala' ? 'මතක තබාගන්න' : 'Remember Me?')
                ],
              ),
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: Text(
                    currentLanguage == 'sinhala' ? 'මුරපදය අමතකද?' : 'Forget Password?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: TColors.primary),
                  ))
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          //Signin button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.emailAndPasswordSignin(),
              child: Text(
                currentLanguage == 'sinhala' ? 'පූරණය වන්න' : 'Sign In',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          //Create Account Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Get.to(() => const SignUpScreen());
              },
              child: Text(
                currentLanguage == 'sinhala' ? 'නව ගිණුමක් සාදන්න' : 'Create an Account',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          // const SizedBox(
          //   height: TSizes.spaceBtwSections,
          // ),
        ]),
      ),
    );
  }
}
