import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../views/history_screen.dart'; // تأكد من المسار

class HomeController extends GetxController {
  // 1. إدارة حقل البحث
  final searchController = TextEditingController();

  // 2. إدارة صورة البروفايل (مهم جداً: استخدمنا .obs لجعلها تفاعلية)
  // Rxn<File> تعني متغير يقبل قيمة File أو null وقابل للمراقبة
  var profileImage = Rxn<File>();

  // دالة لتحديث الصورة
  void updateProfileImage(File? image) {
    profileImage.value = image;
  }

  // دالة الذهاب لسجل البحث
  void goToHistory() {
    String text = searchController.text.trim();
    if (text.isNotEmpty) {
      // الانتقال باستخدام GetX
      Get.to(() => HistoryScreen(searchText: text));
      searchController.clear();
    }
  }
}