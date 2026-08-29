import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotosScreen extends StatefulWidget {
  @override
  _FotosScreenState createState() => _FotosScreenState();
}

class _FotosScreenState extends State<FotosScreen> {
  List<File> _imageFiles = [];

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: _imageFiles.isEmpty
          ? Center(
              child: Text(
                ' ',
              ),
            )
          : ListView.builder(
              itemCount: _imageFiles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    _imageFiles[index],
                    width: MediaQuery.of(context).size.width * 0.3,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Tirar Foto',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
