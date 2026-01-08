import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _fontSize = 16.0;
  double _brightness = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // بطاقة حجم الخط
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
                      Text('حجم الخط',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Slider(
                    value: _fontSize,
                    min: 12,
                    max: 24,
                    divisions: 6,
                    label: '${_fontSize.round()}',
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey[300],
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('صغير', style: TextStyle(color: Colors.grey)),
                      Text('كبير', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'هذا النص بحجم الخط الحالي',
                        style: TextStyle(fontSize: _fontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // بطاقة السطوع
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.brightness_6, color: Colors.orange),
                      SizedBox(width: 10),
                      Text('سطوع الشاشة',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Slider(
                    value: _brightness,
                    min: 0.1,
                    max: 1.0,
                    divisions: 10,
                    label: '${(_brightness * 100).round()}%',
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey[300],
                    onChanged: (value) {
                      setState(() {
                        _brightness = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.brightness_low, color: Colors.grey),
                      Icon(Icons.brightness_high, color: Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // زر حفظ الإعدادات
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('حفظ الإعدادات', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
