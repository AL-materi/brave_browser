import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  // حقن المتحكم
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr), // العنوان مترجم
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // 1. بطاقة تغيير اللغة
          Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.blue),
              title: Text('تغيير اللغة / Change Language'),
              trailing: Icon(Icons.swap_horiz),
              onTap: () => controller.changeLanguage(),
            ),
          ),

          SizedBox(height: 20),

          // 2. بطاقة حجم الخط
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.format_size, color: Colors.orange),
                      SizedBox(width: 10),
                      Text('font_size'.tr,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Obx: لتحديث السلايدر عند تحريكه
                  Obx(() => Slider(
                        value: controller.fontSize.value,
                        min: 12,
                        max: 30,
                        divisions: 6,
                        label: '${controller.fontSize.value.round()}',
                        activeColor: Colors.orange,
                        onChanged: (value) => controller.changeFontSize(value),
                      )),

                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.grey[100],
                    child: Center(
                      // Obx: النص سيتغير حجمه فوراً
                      child: Obx(() => Text(
                            'هذا النص سيتغير حجمه',
                            style:
                                TextStyle(fontSize: controller.fontSize.value),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // 3. زر حفظ وخروج
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('save_settings'.tr,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
