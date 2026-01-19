import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // متغيرات قابلة للمراقبة (Obs)
  var fontSize = 16.0.obs;
  var brightness = 0.5.obs;

  // دالة تغيير اللغة
  void changeLanguage() {
    if (Get.locale?.languageCode == 'ar') {
      Get.updateLocale(Locale('en'));
    } else {
      Get.updateLocale(Locale('ar'));
    }
  }

  // دالة تغيير حجم الخط
  void changeFontSize(double value) {
    fontSize.value = value;
  }

  // دالة تغيير السطوع (محاكاة)
  void changeBrightness(double value) {
    brightness.value = value;
    // هنا يمكن إضافة كود لتغيير سطوع التطبيق فعلياً باستخدام Theme
    Get.changeTheme(
      Get.isDarkMode ? ThemeData.light() : ThemeData.dark()
    ); 
    // ملاحظة: تغيير الثيم بالكامل يتطلب إعدادات إضافية، سنكتفي حالياً بتغيير القيمة
  }
}