import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
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
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
              TextFormField(
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
