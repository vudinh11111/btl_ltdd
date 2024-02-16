import 'dart:io';
import 'dart:math';

import 'package:btl/data/data.dart';
import 'package:btl/data/post_data.dart';
import 'package:btl/google_drive/ggdriver.dart';
import 'package:btl/screens/cart_home/head_tab/head_tab_create.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CreateProduct extends StatefulWidget {
  Data data;
  CreateProduct(this.data);
  @override
  _CreateProduct createState() => _CreateProduct();
}

class _CreateProduct extends State<CreateProduct> {
  ImagePicker _imagePicker = ImagePicker();
  TextEditingController _sizeController = TextEditingController();
  List<String> _sizes = [];
  List _images = [];
  TextEditingController email_pay = TextEditingController();
  TextEditingController tien = TextEditingController();
  TextEditingController ten = TextEditingController();
  TextEditingController mieuta = TextEditingController();
  String generateUniqueUid() {
    final random = Random();

    // Generate 8 random digits
    final digitPart =
        List.generate(8, (index) => random.nextInt(10).toString()).join();

    // Generate 1 random character from 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    final characterPart = String.fromCharCode(
      random.nextInt(26) + 'a'.codeUnitAt(0),
    );

    return digitPart + characterPart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black12,
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: _images.isNotEmpty
                  ? HeadTapCreate(_images)
                  : Center(
                      child: Text("Ảnh sản phẩm muốn bán"),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final files = await _imagePicker.pickMultiImage();
                        setState(() {
                          if (files.isNotEmpty)
                            for (int i = 0; i < files.length; i++) {
                              _images.add((files[i].path));
                            }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text("Thêm ảnh"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(children: [
                      Text("Hướng dẫn"),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Nhấn lâu vào ảnh trong máy của bạn để chọn nhiều ảnh cần thêm, nếu muốn thêm lại vui lòng Hủy ảnh",
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.priority_high,
                          size: 15, // Adjust the size as needed
                        ),
                      )
                    ]),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_images.isNotEmpty) _images = [];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text("Hủy ảnh"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: GridView.builder(
                itemCount: _sizes.length,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  mainAxisExtent: 50,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        "${_sizes[index]}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    controller: _sizeController,
                    maxLength: 5,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Size",
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_sizeController.text.isNotEmpty) {
                        _sizes.add(_sizeController.text);
                        _sizeController.clear();
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text("Thêm"),
                  ),
                ),
              ],
            ),
            TextField(
              controller: ten,
              decoration: InputDecoration(
                  label: Text("Nhập tên sản phẩm"),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: email_pay,
              decoration: InputDecoration(
                  label: Text("Nhập Email/tai khoan Paypal"),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: tien,
              decoration: InputDecoration(
                  label: Text("Nhập số tiền"), border: OutlineInputBorder()),
            ),
            Align(
              child: TextField(
                controller: mieuta,
                maxLength: 1000,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Miêu tả", border: OutlineInputBorder()),
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("Chốt"),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  GoogleApiDr postimage = GoogleApiDr();
                  PostTakeData postTake = PostTakeData();
                  final namefile = generateUniqueUid();
                  for (int i = 0; i < _images.length; i++) {
                    final idfile = await postimage.addFile(
                        "${namefile}", File(_images[i]));
                    await postTake.post_take_data({
                      "image_url":
                          'https://drive.google.com/uc?export=view&id=${idfile}',
                      "product_id": namefile,
                    }, "images");
                  }
                  for (int i = 0; i < _sizes.length; i++) {
                    await postTake.post_take_data({
                      "size": _sizes[i],
                      "product_id": namefile,
                    }, "size");
                  }

                  await postTake.post_take_data({
                    "product_id": namefile,
                    "nguoiban": widget.data.id,
                    "tien": tien.text,
                    "name": ten.text,
                    "mieuta": mieuta.text,
                    "email_tt": email_pay.text
                  }, "sanpham");

                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
