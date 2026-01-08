import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImageScreen extends StatefulWidget {
  final File? currentImage;
  final Function(File?)? onImageSelected;
  
  ProfileImageScreen({
    this.currentImage,
    this.onImageSelected,
  });
  
  @override
  _ProfileImageScreenState createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  
  @override
  void initState() {
    super.initState();
    _selectedImage = widget.currentImage;
  }
  
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        // إرسال الصورة المحددة
        _sendImageBack();
      }
    } catch (e) {
      print('خطأ: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  void _sendImageBack() {
    if (widget.onImageSelected != null) {
      widget.onImageSelected!(_selectedImage);
    }
  }
  
  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    if (widget.onImageSelected != null) {
      widget.onImageSelected!(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تغيير صورة البروفايل'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // زر حفظ إذا كانت هناك تغييرات
          if (_selectedImage != widget.currentImage)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _sendImageBack();
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // عرض الصورة الحالية
              Container(
                width: 250,
                height: 250,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange, width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: _selectedImage == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, size: 100, color: Colors.grey[400]),
                            SizedBox(height: 15),
                            Text(
                              'لا توجد صورة',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ClipOval(
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(Icons.error, color: Colors.red),
                            );
                          },
                        ),
                      ),
              ),
              
              // الأزرار
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // زر المعرض
                      ListTile(
                        leading: Icon(Icons.photo_library, color: Colors.blue),
                        title: Text('اختيار من المعرض'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => _pickImage(ImageSource.gallery),
                      ),
                      
                      Divider(height: 1),
                      
                      // زر الكاميرا
                      ListTile(
                        leading: Icon(Icons.camera_alt, color: Colors.green),
                        title: Text('التقاط صورة جديدة'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => _pickImage(ImageSource.camera),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // زر إزالة الصورة
              if (_selectedImage != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _removeImage,
                    icon: Icon(Icons.delete_outline),
                    label: Text('إزالة الصورة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              
              SizedBox(height: 20),
              
              // معلومات
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💡 معلومات',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('• الصورة تظهر في القائمة الجانبية'),
                      Text('• يمكنك اختيار صورة من المعرض'),
                      Text('• أو التقاط صورة جديدة بالكاميرا'),
                      Text('• الصورة محفوظة فقط في هذه الجلسة'),
                    ],
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