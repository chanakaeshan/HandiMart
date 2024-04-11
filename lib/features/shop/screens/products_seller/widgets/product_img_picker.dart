import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:t_store/utils/constants/sizes.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_image != null) {
      try {
        // Implement Firebase Storage upload here
        // Example code:
        // await firebaseStorageRef.putFile(_image!);
        // Once uploaded, you can get the download URL
        // and store it in your Firebase Database
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: getImage,
                child: Text(
                  "Select Product Image",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
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
            
            
          ],
        ),
    );
  }
}
