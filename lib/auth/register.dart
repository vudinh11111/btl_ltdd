import 'dart:math';

import 'package:btl/data/post_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  TextEditingController sodienthoai = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  int generateUniqueUid() {
    final random = Random();
    final characters = '123456789';
    final uniqueId = List.generate(
        9, (index) => characters[random.nextInt(characters.length)]).join();
    return int.parse(uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/tom1.jpg',
                height: 300,
                width: 300,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: sodienthoai,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "so dien thoai",
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: pass,
                obscureText: true, // Để ẩn mật khẩu
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  PostTakeData postdata = PostTakeData();
                  String namenew = name.text.toString();
                  String emailnew =
                      email.text.toString(); // Fix here, use email.text
                  String passnew =
                      pass.text.toString(); // Fix here, use pass.text
                  String sodienthoainew =
                      sodienthoai.text.toString(); // Fix here, use pass.text

                  await postdata.post_take_data({
                    "id": "${generateUniqueUid()}",
                    "name": namenew,
                    "email": emailnew,
                    "pass": passnew,
                    "sodienthoai": sodienthoainew,
                    "avatar": "",
                    "token": "",
                  }, "data");
                  Navigator.of(context).pop();
                },
                child: Text('Sign Up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
