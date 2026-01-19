import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/splash_screen.dart';
import 'utils/translations.dart';
import 'controllers/settings_controller.dart';

void main() {
  // تفعيل الكنترولر عند بدء التشغيل
  Get.put(SettingsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء الكنترولر
    final SettingsController settingsController = Get.find();

    return Obx(() {
      // 🟢 التصحيح: نقرأ القيمة هنا مباشرة لتراقبها GetX بشكل صحيح
      double currentFontSize = settingsController.fontSize.value;
      double scaleFactor = currentFontSize / 16.0;

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brave Browser',
        
        // إعدادات الثيم
        theme: ThemeData(
          primaryColor: Colors.orange,
          appBarTheme: AppBarTheme(backgroundColor: Colors.orange),
        ),

        // إعدادات الترجمة
        translations: MyTranslations(),
        locale: Locale('ar'),
        fallbackLocale: Locale('en'),

        // تطبيق حجم الخط الجديد على كل الشاشات
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(scaleFactor),
            ),
            child: child!,
          );
        },

        home: SplashScreen(),
      );
    });
  }
}