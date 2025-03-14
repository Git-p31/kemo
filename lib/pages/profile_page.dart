import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;

  void _openAdminPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.article, color: Colors.blue),
                title: Text('Создать новость'),
                onTap: () {
                  Navigator.pop(context);
                  _showCreateNewsDialog(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.event, color: Colors.green),
                title: Text('Создать событие'),
                onTap: () {
                  Navigator.pop(context);
                  _showCreateEventDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreateNewsDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Создать новость', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Заголовок'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Закрыть', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('news').add({
                    'title': title,
                    'description': description,
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Новость сохранена!')),
                    );
                  }
                }
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showCreateEventDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Создать событие', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Название события'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Закрыть', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('events').add({
                    'title': title,
                    'description': description,
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Событие создано!')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Заполните все поля!')),
                  );
                }
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800], // Темно-синий
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60, // Уменьшили размер
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 20, // Уменьшили размер кнопки
                          backgroundColor: Colors.blue[800], // Темно-синий
                          child: Icon(Icons.edit, size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'Имя пользователя',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  'email@example.com',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _openAdminPanel(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800], // Темно-синий
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: Text('Админ панель', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}
