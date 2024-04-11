import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/common/widgets/shimmers/shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/change_name.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Prrofile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;
                      if (controller.imageUploading.value) {
                        return const TShimmerEffect(
                          height: 80.0,
                          width: 80.0,
                          radius: 80.0,
                        );
                      } else {
                        return CircleAvatar(
                          radius: 42.5,
                          backgroundColor: TColors.primary,
                          foregroundColor: TColors.primary,
                          child: TCircularImage(
                            image: image,
                            fit: BoxFit.cover,
                            width: 80.0,
                            height: 80.0,
                            isNetworkImage: networkImage.isNotEmpty,
                          ),
                        );
                      }
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: Text(
                          "Change Profile Picture",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: TColors.primary),
                        ))
                  ],
                ),
              ),
              //Details
              // SizedBox(
              //   height: TSizes.spaceBtwItems / 2,
              // ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TProfileMenu(
                title: "Name",
                value: controller.user.value.fullName,
                needIcon: true,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              TProfileMenu(
                title: "Username",
                value: controller.user.value.userName,
                onPressed: () {},
              ),
              //
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSectionHeading(
                title: "User Profile Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TProfileMenu(
                title: "User ID",
                icon: Iconsax.copy,
                needIcon: true,
                value: controller.user.value.id,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Email",
                value: controller.user.value.email,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Phone",
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Gender",
                value: "Male",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Date of Birth",
                value: "12 Aug, 2003",
                onPressed: () {},
              ),

              const Divider(),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopUp(),
                  child: Text(
                    "Close Account",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
