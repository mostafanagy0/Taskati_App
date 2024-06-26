import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/storage/local_storage.dart';
import 'package:taskati/feature/profile/profile_view.dart';

// ----------------- show image-----------------
showImageDialog(context, {onTapCamera, onTapGallery}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTapCamera,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor),
                  child: Text(
                    'Upload from Camera',
                    style: TextStyle(color: AppColors.lightBG),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: onTapGallery,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor),
                  child: Text(
                    'Upload from Gallery',
                    style: TextStyle(color: AppColors.lightBG),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

//------------------- show name ----------------
showNameDialog(context, name) {
  var formkey = GlobalKey<FormState>();
  var textCon = TextEditingController(text: name);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: textCon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Your Name mustn\'t be empty';
                    }
                    return null;
                  },
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      AppLocal.cacheData(AppLocal.NameKey, textCon.text);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ProfileView(),
                      ));
                    }
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor),
                    child: Text(
                      'Update Your Name',
                      style: TextStyle(color: AppColors.lightBG),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<String?> getImagefromCamera() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    AppLocal.cacheData(AppLocal.ImageKey, pickedImage.path);
    return pickedImage.path;
  } else {
    return null;
  }
}

Future<String?> getImagefromGallery() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    AppLocal.cacheData(AppLocal.ImageKey, pickedImage.path);
    return pickedImage.path;
  } else {
    return null;
  }
}
