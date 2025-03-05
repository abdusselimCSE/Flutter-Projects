import 'package:flutter/material.dart';
import 'package:sum_app/app/app_colors.dart';

// void showSnackBarMessage(BuildContext context, String message,
//     [bool isErrorMessage = false]) {
//   Get.snackbar(
//     isErrorMessage ? "Error" : "Success",
//     message,
//     snackPosition: SnackPosition.BOTTOM,
//     backgroundColor: isErrorMessage ? Colors.red : null,
//   );
// }

void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    backgroundColor: isErrorMessage ? Colors.red : AppColors.themeColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
