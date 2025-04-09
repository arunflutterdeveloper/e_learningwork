import 'package:e_learning/utill/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utill/app_strings.dart';


class CustomSnackBar {
  static void showBottom(String msg) {
    Get.snackbar(
      AppStrings.alert.tr,
      // icon: const Icon(Icons.error_outline,color: AppColors.red,),
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:AppColors.black.withOpacity(0.8),
      colorText: AppColors.white,
    );
  }

  static void showTop(String msg) {
    Get.snackbar(
      AppStrings.title.tr,
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
  }

  // static void showBottomTwo(String msg,BuildContext context){
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(msg)
  //   ));
  // }
}
