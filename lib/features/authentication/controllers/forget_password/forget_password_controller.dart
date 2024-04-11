import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_scree_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //Send reset passwordemail
  sendPasswordResetEmail() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          "Logging you in...", TImages.doccerAnimation);

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
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Send Email to reset Passsword
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success screen
      TLoaders.succcesSnackBar(
          title: "Email Sent",
          message: "Email Link is sent to reset your password".tr);

      //Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      try {
        //Loading
        TFullScreenLoader.openLoadingDialog(
            "Logging you in...", TImages.doccerAnimation);

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

        //Send Email to reset Passsword
        await AuthenticationRepository.instance.sendPasswordResetEmail(email);

        //Remove Loader
        TFullScreenLoader.stopLoading();

        //Show success screen
        TLoaders.succcesSnackBar(
            title: "Email Sent",
            message: "Email Link is sent to reset your password".tr);
      } catch (e) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        //Show error message
        TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      }
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
