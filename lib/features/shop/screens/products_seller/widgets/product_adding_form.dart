import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/product/product_adding_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/validators/validation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TProductAddingForm extends StatelessWidget {
  const TProductAddingForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductAddingController());
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    return Form(
      key: controller.productAddingFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(children: [
          TextFormField(
            controller: controller.title,
            validator: (value) => TValidator.validateEmptyText("Product Title", value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.box),
              labelText:  currentLanguage == 'sinhala' ? 'නිෂ්පාදන මාතෘකාව(නම)' : 'Product Title'
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.description,
            validator: (value) => TValidator.validateEmptyText("Description", value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.box),
              labelText:  currentLanguage == 'sinhala' ? 'විස්තර' : 'Description'
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.category,
            validator: (value) => TValidator.validateEmptyText("Category", value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.box),
              labelText:  currentLanguage == 'sinhala' ? 'වර්ගය' : 'Category'
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.price,
            validator: (value) => TValidator.validateEmptyText("Price", value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.box),
              labelText:  currentLanguage == 'sinhala' ? 'මිල' : 'Price'
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.salePrice,
            validator: (value) => TValidator.validateEmptyText("Selling Price", value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.box),
              labelText:  currentLanguage == 'sinhala' ? 'විකුණුමි මිල (වට්ටම් දීමෙන් පසු)' : 'Selling Price (After applying Discount)'
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: controller.stock,
            validator: (value) => TValidator.validateEmptyText("Stock Count", value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.box),
              labelText:  currentLanguage == 'sinhala' ? 'පවතින කොටස් ගණන' : 'Available Stocks Count'
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          const ImagePickerScreen(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addProduct(),
              child: Text(
                currentLanguage == 'sinhala' ? 'නිෂ්පාදනය සුරකින්න' : 'Save Product',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          
          // const SizedBox(
          //   height: TSizes.spaceBtwSections,
          // ),
        ]),
      ),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});
  

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  
  File? _image;
  XFile? pickedImg;
  String imgURL = '';
  final controller = Get.put(ProductAddingController());

  getPickedImg() {
    return pickedImg;
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        pickedImg = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    final currentLanguage = localStorage.read('currentLanguage') ?? 'english';
    return Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Center(
              
                child: Text(
                  currentLanguage == 'sinhala' ? 'සුරකින අතරතුර පිංතූරයක් තෝරන්න' : "Select a Product Image While Saving",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
                ),
              
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            _image != null
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: FileImage(_image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            pickedImg != null
              ? Container(
                 child: Text(
                  pickedImg!.path
                 ),
               )
               : Container(),
            
          ],
        ),
    );
  }
}
