import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 1. إضافة المكتبة

class HistoryScreen extends StatelessWidget {
  final String searchText;

  HistoryScreen({required this.searchText});

  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية
    List<String> history = [
      'YouTube',
      'Learn Flutter',
      'GetX Tutorial',
    ];

    if (searchText.isNotEmpty) {
      history.insert(0, searchText);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('history'.tr), // 2. استخدام الترجمة
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(Icons.history, color: Colors.grey),
              title: Text(history[index]),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}