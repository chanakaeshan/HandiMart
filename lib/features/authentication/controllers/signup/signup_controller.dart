import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:t_store/common/widgets/loaders/loaders.dart";
import "package:t_store/data/repositories/authentication/authentication_repository.dart";
import "package:t_store/data/repositories/user/user_repository.dart";
import "package:t_store/features/authentication/models/user_model.dart";
import "package:t_store/features/authentication/screens/signup/verify_email.dart";
import "package:t_store/utils/constants/image_strings.dart";
import "package:t_store/utils/helpers/network_manager.dart";
import "package:t_store/utils/popups/full_scree_loader.dart";

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  //SignUp
  void signup() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          "As we are processing your information...", TImages.doccerAnimation);

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
      if (!signUpFormKey.currentState!.validate()) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account , you must read and accept the Privacy Policy & Terms of use");
      }

      //Register user intheFirebase Authentication &save user data in Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailandPassword(
              email.text.trim(), password.text.trim());

      //Save Authenticted user data in firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: "",
          role: getRoleFromLocalStorage);
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show Success Mesage
      TLoaders.succcesSnackBar(
          title: "Congratulations",
          message: "Your account has been created. Verify mail to cntinue");

      //Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  String get getRoleFromLocalStorage {
    final localStorage = GetStorage();
    final role = localStorage.read('role') ?? 'buyer';
    return role;
  }
}
