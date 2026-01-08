import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final String searchText;

  HistoryScreen({required this.searchText});

  @override
  Widget build(BuildContext context) {
    List<String> history = [
      ' يوتيوب',
      'yaqob almateri'
          'تعلم فلاتر',
    ];

    // هذا السطر مهم: يضيف البحث الجديد للسجل
    if (searchText.isNotEmpty) {
      history.insert(0, searchText);
    }

    return Scaffold(
      appBar: AppBar(title: Text('سجل البحث')),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text(history[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
