import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/banners/banners_repositoty.dart';
import 'package:t_store/features/shop/models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  //Variables
  final carauselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carauselCurrentIndex.value = index;
  }

  //Fetch banners
  Future<void> fetchBanners() async {
    try {
      //Loading
      isLoading.value = true;

      //Ftech banners
      final bannerRepository = Get.put(BannerRepository());
      final banners = await bannerRepository.fetchBanners();

      //Assign banners
      this.banners.assignAll(banners);
    } catch (e) {
      //Show error message
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      //Remove Loader
      isLoading.value = false;
    }
  }
}
