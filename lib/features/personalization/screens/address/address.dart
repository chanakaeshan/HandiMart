import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/loaders/animation_loader.dart';
import 'package:t_store/common/widgets/shimmers/shimmer.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                //Use key to trigger refresh
                key: Key(addressController.refreshData.value.toString()),
                future: addressController.getAllUserAddresses(),
                builder: (context, snapshot) {
                  final emptyWidget = TAnimationLoaderWidget(
                    text: "Whoops! Address is Empty...",
                    animation: TImages.pencilAnimation,
                    showAction: true,
                    actionText: "Let's add some",
                    onActionPressed: () =>
                        Get.to(() => const AddNewAddressScreen()),
                  );
                  final loader = Column(
                    children: [
                      TShimmerEffect(
                        width: TDeviceUtils.getScreenWidth(context) - 30.0,
                        height: 120.0,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TShimmerEffect(
                        width: TDeviceUtils.getScreenWidth(context) - 30.0,
                        height: 120.0,
                      ),
                    ],
                  );
                  final response = TCloudHelperFunctions.checkMultiRecordState(
                      loader: loader,
                      snapshot: snapshot,
                      nothingFound: emptyWidget);
                  if (response != null) return response;

                  final addresses = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        return TSingleAddress(
                          address: addresses[index],
                          onTap: () =>
                              addressController.selectAddress(addresses[index]),
                        );
                      });
                },
              ),
            )),
      ),
    );
  }
}
