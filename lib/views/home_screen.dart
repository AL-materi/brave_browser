import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:io';
import '../controllers/home_controller.dart';
// import '../controllers/auth_controller.dart'; // من أجل تسجيل الخروج
import 'history_screen.dart';
import 'profile_image_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  // حقن المتحكم
  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('title'.tr), // ترجمة العنوان
        centerTitle: true,
      ),

      // القائمة الجانبية (Drawer)
      drawer: _buildDrawer(context),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'search_hint'.tr, // ترجمة التلميح
                      border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => controller.goToHistory(),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: Text('search_btn'.tr,
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              // نص توضيحي بسيط
              '${'search_hint'.tr} -> ${'search_btn'.tr}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.home, color: Colors.orange),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.history, color: Colors.grey),
                  onPressed: () => controller.goToHistory()),
              IconButton(
                icon: Icon(Icons.menu, color: Colors.grey),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // فصلنا الدروج في دالة لترتيب الكود
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back(); // إغلاق الدروج
                    // الذهاب لصفحة الصورة وتمرير دالة التحديث
                    Get.to(() => ProfileImageScreen(
                          currentImage: controller.profileImage.value,
                          onImageSelected: (file) =>
                              controller.updateProfileImage(file),
                        ));
                  },
                  // Obx: يراقب تغيير الصورة ويحدث الواجهة فوراً
                  child: Obx(() => Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                            image: controller.profileImage.value != null
                                ? FileImage(controller.profileImage.value!)
                                : AssetImage("images/Luffy.png")
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 10),
                Text('Yaqob',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.purple),
            title: Text('history'.tr),
            onTap: () {
              Get.back();
              Get.to(() => HistoryScreen(searchText: ''));
            },
          ),
          // --- خيار تغيير الصورة ---
          ListTile(
            leading: Icon(Icons.person, color: Colors.green), // أيقونة المستخدم
            title: Text('profile_pic'.tr), // النص مترجم (تغيير صورة البروفايل)
            onTap: () {
              Get.back(); // 1. إغلاق القائمة الجانبية أولاً

              // 2. الذهاب لصفحة اختيار الصورة
              Get.to(() => ProfileImageScreen(
                    // نمرر الصورة الحالية ليعرفها التطبيق
                    currentImage: controller.profileImage.value,

                    // هذه الدالة ستعمل عندما يختار المستخدم صورة جديدة
                    onImageSelected: (file) =>
                        controller.updateProfileImage(file),
                  ));
            },
          ),
          // ------------------------
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text('settings'.tr),
            onTap: () {
              Get.back();
              Get.to(() => SettingsScreen());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('logout'.tr),
            onTap: () {
              // مسح بيانات الدخول والعودة للبداية
              Get.offAll(() => LoginScreen());
              Get.delete<HomeController>(); // تنظيف الذاكرة
            },
          ),
        ],
      ),
    );
  }
}
