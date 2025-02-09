import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  Get.snackbar(
    isErrorMessage ? "Error" : "Success",
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isErrorMessage ? Colors.red : null,
  );
}
