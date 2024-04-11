import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/terms_and_condtions.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    return Form(
        key: controller.signUpFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText("First Name", value),
                    expands: false,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                      labelText: currentLanguage == 'sinhala' ? 'මුල් නම' : 'First Name',
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText("Last Name", value),
                    expands: false,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                      labelText: currentLanguage == 'sinhala' ? 'අවසාන නම' : 'Last Name',
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            //UserName
            TextFormField(
              expands: false,
              controller: controller.userName,
              validator: (value) =>
                  TValidator.validateEmptyText("UserName", value),
              decoration: InputDecoration(
                labelText: currentLanguage == 'sinhala' ? 'පරිෂීලක නාමය' : 'Username',
                prefixIcon: const Icon(Iconsax.user_edit),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            //Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                labelText: currentLanguage == 'sinhala' ? 'ඊ-ලිපිනය' : 'Email',
                prefixIcon: const Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            //Phone Number
            TextFormField(
              validator: (value) => TValidator.validatePhoneNumber(value),
              controller: controller.phoneNumber,
              decoration: InputDecoration(
                labelText: currentLanguage == 'sinhala' ? 'දුරකතන අංකය' : 'Phone',
                prefixIcon: const Icon(Iconsax.call),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            //Passwoord
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
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //Terms andConitions checkbox
            const TTermsAndConditionsCheckBox(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            //Signup button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: Text(
                    currentLanguage == 'sinhala' ? 'ගිණුම සාදන්න' : 'Create Account',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: Colors.white),
                  )),
            )
          ],
        ));
  }
}
