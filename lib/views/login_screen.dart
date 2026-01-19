import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart'; // استدعاء المتحكم

// حولناها إلى StatelessWidget لأن GetX يتكفل بتحديث الحالة
class LoginScreen extends StatelessWidget {
  
  // حقن (Inject) المتحكم لاستخدامه
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr), // استخدام الترجمة
        centerTitle: true,
        actions: [
          // زر مؤقت لتجربة تغيير اللغة
          TextButton.icon(
            onPressed: () {
              // كود تغيير اللغة: إذا كانت عربي حولها إنجليزي والعكس
              if (Get.locale?.languageCode == 'ar') {
                Get.updateLocale(Locale('en'));
              } else {
                Get.updateLocale(Locale('ar'));
              }
            },
            icon: Icon(Icons.language, color: Colors.white),
            label: Text(
              Get.locale?.languageCode == 'ar' ? 'English' : 'عربي',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'login'.tr, // سيترجم تلقائياً حسب اللغة المختارة
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              
              // حقل اسم المستخدم
              TextField(
                controller: controller.usernameController, // الربط مع المتحكم
                decoration: InputDecoration(
                  labelText: 'username'.tr, // ترجمة التسمية
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              
              // حقل كلمة المرور
              TextField(
                controller: controller.passwordController, // الربط مع المتحكم
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'password'.tr, // ترجمة التسمية
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 30),
              
              // زر الدخول
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.login(), // استدعاء الدالة من المتحكم
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'login'.tr,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}