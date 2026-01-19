import 'package:flutter/material.dart';
import 'package:get/get.dart'; // استخدمنا Get للتنقل
import 'login_screen.dart'; // أو home_screen حسب التوجيه

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // المؤقت للانتقال
    Future.delayed(Duration(seconds: 3), () {
      // استخدام Get.off للنقل ومنع العودة للسبلاش
      Get.off(() => LoginScreen());
    });

    return Scaffold(
      backgroundColor: Colors.black, // لون الخلفية
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- هنا التغيير: وضعنا صورة بدلاً من الأيقونة ---
            Image.asset(
              'images/icon.png', // <-- اسم صورتك هنا
              width: 150, // عرض الصورة
              height: 150, // ارتفاع الصورة
            ),
            // ------------------------------------------------

            SizedBox(height: 20),
            Text('Brave', style: TextStyle(fontSize: 40, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
