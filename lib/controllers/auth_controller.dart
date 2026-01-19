import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/home_screen.dart'; // تأكد أن ملف home_screen موجود في مجلد views

class AuthController extends GetxController {
  // تعريف متحكمات النصوص هنا بدلاً من الشاشة
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // دالة تسجيل الدخول
  void login() {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // استخدام Get.offAll بدلاً من Navigator.pushReplacement
      // هذا يحذف شاشة الدخول من الذاكرة ويذهب للرئيسية
      Get.offAll(() => HomeScreen());
      
      // رسالة ترحيبية صغيرة (اختياري)
      Get.snackbar(
        'مرحباً بك', 
        'تم تسجيل الدخول بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      // إظهار رسالة خطأ باستخدام GetX
      Get.snackbar(
        'تنبيه', 
        'يرجى إدخال اسم المستخدم وكلمة المرور',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}