import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      //Custom AppBar
      appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            "ReAuthenticate User",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Re authenticate with your user account to remove your account",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //Text Field and Button
            Form(
                key: controller.reAuthFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.verifEmail,
                      validator: (value) => TValidator.validateEmail(value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Obx(
                      () => TextFormField(
                        validator: (value) =>
                            TValidator.validatePassword(value),
                        controller: controller.verifyPassword,
                        obscureText: controller.hidePassword.value,
                        expands: false,
                        decoration: InputDecoration(
                            labelText: TTexts.password,
                            prefixIcon: const Icon(Iconsax.user_edit),
                            suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                                icon: controller.hidePassword.value
                                    ? const Icon(Iconsax.eye_slash)
                                    : const Icon(Iconsax.eye))),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () =>
                      controller.reAuthenticateEmailandPasswordUser(),
                  child: Text(
                    "Verify",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
