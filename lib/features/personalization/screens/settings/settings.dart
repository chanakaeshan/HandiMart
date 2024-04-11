import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/features/personalization/screens/settings/change_language.dart';
import 'package:t_store/features/shop/controllers/settings_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/features/shop/screens/load_data/load_data.dart';
import 'package:t_store/features/shop/screens/order/order.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    final role = localStorage.read('role') ?? 'buyer';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          //Header
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                //AppBar
                TAppBar(
                  title: Text(
                    currentLanguage == 'sinhala' ? 'ගිණුම' : "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),
                //User Profile Card
                TUserProfileTile(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems * 1.5,
                )
              ],
            ),
          ),
          //Body
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Account Settings
                TSectionHeading(
                  title: currentLanguage == 'sinhala' ? 'ගිණුම් සැකසුම' : "Account Settings",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
    
                TSettingMenuTile(
                  onTap: () => role == 'buyer' ? Get.to(() => const UserAddressScreen()) : {},
                  icon: Iconsax.safe_home,
                  title: currentLanguage == 'sinhala' ? 'මගේ ලිපිනයන්' :  "My Address",
                  subtitle: currentLanguage == 'sinhala' ? 'මගේ මිලදී ගැනීමේ ලීපිනයන් එක්කරන්න' : "Set Shipping delivery address",
                ),
                TSettingMenuTile(
                  onTap: () => role == 'buyer' ? Get.to(() => const CartScreen()) : {},
                  icon: Iconsax.shopping_cart,
                  title: currentLanguage == 'sinhala' ? 'මගේ කරත්තය' : "My Cart",
                  subtitle: currentLanguage == 'sinhala' ? 'නිෂ්පාදන කරත්තය බලන්න' : "Add, remove Products and move to checkout",
                ),
                TSettingMenuTile(
                  onTap: () => role == 'buyer' ? Get.to(() => const OrderScreen()) : {},
                  icon: Iconsax.bag_tick,
                  title: currentLanguage == 'sinhala' ? 'මගේ ඇණවුම්' : "My Orders",
                  subtitle:  currentLanguage == 'sinhala' ? "ලැබීමට තිබෙන සහ ලැබුණු ඇණවුම්" : "See Received and Pending orders",
                ),
                TSettingMenuTile(
                  icon: Iconsax.bank,
                  title: currentLanguage == 'sinhala' ? 'මගේ ගිණුම' : "My Account",
                  subtitle: currentLanguage == 'sinhala' ? "බැංකු ගිණුම් එක් කරන්න":"Withdraw balance to registered bank account",
                ),
                TSettingMenuTile(
                  icon: Iconsax.discount_shape,
                  title: currentLanguage == 'sinhala' ? 'මගේ වවුචර' : "My Coupons",
                  subtitle: currentLanguage == 'sinhala' ? 'වට්ටම් දීමේ වවුචර ලයිස්තුව' : "List of all discounted coupons",
                ),
                TSettingMenuTile(
                  icon: Iconsax.notification,
                  title: currentLanguage == 'sinhala' ? 'දැනුම්දීම්' : "Notifications",
                  subtitle: currentLanguage == 'sinhala' ? 'දැනුම්දීම් සියල්ල බලන්න' : "Set any kind of Notification Message",
                ),
                TSettingMenuTile(
                  icon: Iconsax.security_card,
                  title: currentLanguage == 'sinhala' ? 'ගිණුම් පෞද්ගලිකත්වය' : "Account Privacy",
                  subtitle: currentLanguage == 'sinhala' ? 'දත්ත පරිභෝජනය සහ සම්බන්දිත ගිණුම් පාලනය කරන්න' : "Manage Data usage and connected accounts",
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                const TSectionHeading(
                  title: "App Settings",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSettingMenuTile(
                  onTap: () => Get.to(() => const LoadDataScreen()),
                  icon: Iconsax.document_upload,
                  title: "Load Data",
                  subtitle: "Upload data to your Cloud Firebase",
                ),
                TSettingMenuTile(
                  onTap: () => Get.to(() => const ChangeLanguageScreen()),
                  icon: Iconsax.language_circle,
                  title: "Change Language",
                  subtitle: "Set app language to English or Sinhala",
                ),
                TSettingMenuTile(
                  icon: Iconsax.location,
                  title: "Geolocation",
                  subtitle: "Set Recomendation based on location",
                  trailing: Obx(
                    () => Switch(
                      value: controller.geoLocationSwitch.value,
                      onChanged: (value) =>
                          controller.geoLocationSwitch.value = value,
                    ),
                  ),
                ),
                TSettingMenuTile(
                  icon: Iconsax.security_user,
                  title: "Safe Mode",
                  subtitle: "Search result is safe for all ages",
                  trailing: Obx(
                    () => Switch(
                      value: controller.safeModeSwitch.value,
                      onChanged: (value) =>
                          controller.safeModeSwitch.value = value,
                    ),
                  ),
                ),
                TSettingMenuTile(
                  icon: Iconsax.image,
                  title: "HD Image Quality",
                  subtitle: "Set Image quality tobe seen",
                  trailing: Obx(
                    () => Switch(
                      value: controller.hdImgQualitySwitch.value,
                      onChanged: (value) =>
                          controller.hdImgQualitySwitch.value = value,
                    ),
                  ),
                ),

                //Logout Button
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: Text("Logout",
                          style: Theme.of(context).textTheme.titleMedium)),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
