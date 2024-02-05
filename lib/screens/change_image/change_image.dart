import 'dart:io';
import 'package:btl/data/data.dart';
import 'package:btl/data/update.dart';
import 'package:btl/google_drive/ggdriver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Change_Image extends StatefulWidget {
  String avatar;
  Data data;
  VoidCallback? callback;
  Change_Image(this.avatar, this.data, [this.callback]);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Change_Image> {
  File? _imageFile;
  String? _imagelist;

  Future<void> _pickImageFromDevice(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        _imagelist = null;
      }
    });
  }

  void _onOKPressed() async {
    final GoogleApiDr gdr = GoogleApiDr();
    final Update ptd = Update();
    File? filePath;
    if (_imageFile != null) {
      filePath = File(_imageFile!.path);
    } else if (_imagelist != null) {
      final filePathtest = await gdr.loadAsset(_imagelist!);
      filePath = File(filePathtest);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final newfile = await gdr.addOrUpdateFile(widget.data.id!, filePath);
      final data = {
        "avatar": "https://drive.google.com/uc?export=view&id=${newfile}"
      };
      await ptd.UpdateData(data, "change_avatar/${widget.data.id}");
      setState(() {
        widget.data.avatar = data["avatar"];
      });

      Navigator.pop(context);
      Navigator.pop(context);
      widget.callback!();
    } catch (e) {
      print('Error: $e');

      Navigator.pop(context);
    }
  }

  Future<void> _pickImageFromGrid(BuildContext context) async {
    final imagePath = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageGridPage()));

    setState(() {
      if (imagePath != null) {
        _imageFile = null;
        _imagelist = imagePath as String;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn ảnh làm avatar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _imageFile != null
                      ? FileImage(_imageFile!)
                      : _imagelist != null
                          ? AssetImage(_imagelist!) as ImageProvider
                          : NetworkImage(widget.avatar),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () => _pickImageFromGrid(context),
                child: Text('Ảnh hệ thống'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _pickImageFromDevice(ImageSource.gallery),
                child: Text('Ảnh của bạn'),
              ),
            ]),
            ElevatedButton(
              onPressed: _onOKPressed,
              child: Text('OK'),
            )
          ],
        ),
      ),
    );
  }
}

class ImageGridPage extends StatelessWidget {
  final List<String> _imageList = [
    'assets/avatar0.jpg',
    'assets/avatar1.jpg',
    'assets/avatar2.jpg',
    'assets/avatar3.jpg',
    //'assets/avatar4.jpg',
    // 'assets/avatar5.jpg',
    //'assets/avatar6.jpg',
    //'assets/avatar7.jpg',
    // 'assets/avatar8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Image Grid'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _imageList.length,
        itemBuilder: (BuildContext context, int index) {
          final imagePath = _imageList[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, imagePath);
            },
            child: Image.asset(
              imagePath,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
