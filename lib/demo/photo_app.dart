import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhoneApp extends StatefulWidget {
  @override
  _PhoneAppState createState() => _PhoneAppState();
}

class _PhoneAppState extends State<PhoneApp> {
  List<File> _images = [];

  final picker = ImagePicker();
  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    PickedFile image = await picker.getImage(
        source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _genImages(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: '选择图片',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
  _pickImage() {
    showModalBottomSheet(
      context: context, 
      builder: (context) => Container(
        height: 160,
        child: Column(
          children: <Widget>[
            _item('拍照', true),
            _item('从相册选择', false)
          ],
        ),
      )
    );
  }
  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto),
      ),
    );
  }
   
  List<Stack> _genImages() {
    return _images.map((img) {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(img, width: 120, height: 90, fit:  BoxFit.fill,)
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _images.remove(img);
                });
              },
              child: ClipOval(
                // 圆角删除
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.black54),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          )
        ],
      );
    }).toList();
  }
}