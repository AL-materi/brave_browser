import 'package:flutter/material.dart';
import 'dart:io';
import 'history_screen.dart';
import 'login_screen.dart';
import 'profile_image_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _searchController = TextEditingController();
  File? _profileImage;

  void _goToHistory() {
    String searchText = _searchController.text.trim();
    if (searchText.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryScreen(searchText: searchText),
        ),
      );
      _searchController.clear();
    }
  }

  void _updateProfileImage(File? image) {
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Brave Browser'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'اكتب للبحث...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _goToHistory,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: Text('بحث', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text('اكتب شيئاً ثم اضغط: بحث',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),

      // القائمة الجانبية
      drawer: Drawer(
        child: ListView(
          // استخدام ListView مباشرة لتجنب مشاكل المساحة
          padding: EdgeInsets.zero,
          children: [
            // ===== رأس القائمة (المحسن) =====
            Container(
              // استخدمنا padding بدلاً من height ثابت لتجنب الـ Overflow
              padding: EdgeInsets.only(top: 50, bottom: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileImageScreen(
                            currentImage: _profileImage,
                            onImageSelected: _updateProfileImage,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 8)
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage("images/Luffy.png")
                                as ImageProvider, // صورة افتراضية
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Yaqob',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                    ),
                  ),
                  Text(
                    'yaqob1it@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // عناصر القائمة
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('الرئيسية'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.purple),
              title: Text('سجل البحث'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => HistoryScreen(searchText: '')));
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.green),
              title: Text('تغيير صورة البروفايل'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileImageScreen(
                      currentImage: _profileImage,
                      onImageSelected: _updateProfileImage,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('الإعدادات'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => SettingsScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('تسجيل الخروج'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (c) => LoginScreen()));
              },
            ),
          ],
        ),
      ),

      // الشريط السفلي
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // شكل جمالي
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
                  icon: Icon(Icons.bookmark, color: Colors.grey),
                  onPressed: () {}),
              IconButton(
                icon: Icon(Icons.history, color: Colors.grey),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => HistoryScreen(searchText: ''))),
              ),
              // زر القائمة الذي كان يسبب المشكلة
              IconButton(
                icon: Icon(Icons.menu, color: Colors.grey),
                onPressed: () {
                  // 3. الحل: استخدام المفتاح لفتح القائمة
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
