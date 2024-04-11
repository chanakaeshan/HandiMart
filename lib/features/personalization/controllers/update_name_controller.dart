import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  //Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          "We are updating your information...", TImages.doccerAnimation);

      //Check Internet Connectivty
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'No Internet Connection',
            message:
                "You are not connected to the network. Please get connected to proceed.");
        return;
      }

      //Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }
      Map<String, dynamic> name = {
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim()
      };
      //Update name in firebase
      await userRepository.updateSingleField(name);

      //Update nameincontroller to reflect instate
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show Success Mesage
      TLoaders.succcesSnackBar(
          title: "Congratulations", message: "Your name has been updated");

      //Move to Verify Email Screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: "Data not saved",
          message:
              "Something went wrongwhile saving your information. You can resave yourdata inyour profile");
    }
  }
}
