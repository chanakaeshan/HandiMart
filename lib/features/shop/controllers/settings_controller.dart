import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final box = GetStorage();
  
  //Variables
  RxBool geoLocationSwitch = false.obs;
  RxBool safeModeSwitch = false.obs;
  RxBool hdImgQualitySwitch = false.obs;
  RxBool isSinhalaLanguage = false.obs;

  // Initialization
 /* @override
  void onInit() {
    super.onInit();
    _loadLanguageFromStorage(); // Load language preference from local storage
  }

  // Function to toggle language between Sinhala and English
  void toggleLanguage() {
    isSinhalaLanguage.value = !isSinhalaLanguage.value;
    _saveLanguageToStorage(); // Save updated language preference to local storage
    // Add logic here to update the app's UI language based on the selected language
  }

  // Private function to load language preference from local storage
  void _loadLanguageFromStorage() {
    final savedLanguage = box.read('currentLanguage'); // Read language preference from local storage
    if (savedLanguage != null) {
      isSinhalaLanguage.value = savedLanguage as bool;
    }
  }

  // Private function to save language preference to local storage
  void _saveLanguageToStorage() {
    box.write('currentLanguage', isSinhalaLanguage.value);
  }*/

}
