import 'dart:io';

import 'package:BitOwi/core/widgets/custom_snackbar.dart';
import 'package:BitOwi/core/widgets/image_picker_modal.dart';
import 'package:BitOwi/utils/aws_upload_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MeController extends GetxController {
  final RxString faceUrl = ''.obs;
  final RxBool isIdImageUploading = false.obs;

  Future<void> pickKYCImage(ValueChanged<String> onPicked) async {
    if (isIdImageUploading.value) return;

    isIdImageUploading.value = true;

    try {
      final XFile? pickedFile =
          await ImagePickerModal.showModal(Get.context!);

      if (pickedFile == null) return;

      final file = File(pickedFile.path);
      final size = await file.length();
      const maxSize = 5 * 1024 * 1024;

      if (size > maxSize) {
        CustomSnackbar.showError(
          title: "Upload Failed",
          message: "Image is too large. Please upload an image under 5MB.",
        );
        return;
      }

      final url = await AwsUploadUtil().upload(file: pickedFile);
        // await context.read<AuthProvider>().setPhoto(url);
      onPicked(url);
    } catch (e) {
      CustomSnackbar.showError(
        title: "Upload Failed",
        message: "Image upload failed, please try again",
      );
    } finally {
      isIdImageUploading.value = false;
    }
  }

  Future<void> onPickIdImage() async {
    await pickKYCImage((String key) {
      faceUrl.value = key;
    });
  }
}
