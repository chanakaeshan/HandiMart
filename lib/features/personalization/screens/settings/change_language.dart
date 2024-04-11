import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/navigation_menu_seller.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final localStorage = GetStorage();
    final role = localStorage.read('role') ?? 'buyer';
    void changeLanguage(language) {
      localStorage.write('currentLanguage', language);
      if (role == 'buyer') {
        Get.to(() => const NavigationMenu());
      } else if (role == 'seller') {
        Get.to(() => const NavigationMenuSeller());
      } else {
        Get.to(() => const NavigationMenu());
      }
    }
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Change Language",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwItems * 3),
            Text(
              "Select a language",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {changeLanguage("english")},
                  style: ElevatedButton.styleFrom(padding: const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20)),
                  child: const Text("English"),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                ElevatedButton(
                  onPressed: () => {changeLanguage("sinhala")},
                  style: ElevatedButton.styleFrom(padding: const EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20)),
                  child: const Text("Sinhala"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}