import 'package:btl/auth/register.dart';
import 'package:btl/changenotifer/changenotifier.dart';
import 'package:btl/data/update.dart';
import 'package:btl/screens/homepage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';
import 'package:btl/auth/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  late List<Data> data;
  bool remember = false;
  ConvertData cv = ConvertData();
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchemailandpass();
  }

  Future fetchemailandpass() async {
    final emailandpass = await SharedPreference.Get_Infor();
    setState(() {
      remember = emailandpass["remember"] ?? false;
      if (remember) {
        email.text = emailandpass["email"] ?? "";
        password.text = emailandpass["password"] ?? "";
        if (email.text.isNotEmpty && password.text.isNotEmpty) {
          LoginToHome();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
      ),
      body: FutureBuilder(
        future: cv.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/tom1.jpg',
                        height: 300,
                        width: 300,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          hintText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          themevl = await SharedPreference.GetTheme();
                          await LoginToHome();
                        },
                        child: Text('Sign In'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: Text("Register here"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future LoginToHome() async {
    // print(_formKey.currentState!.validate() == null);
    try {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        await cv.fetchData();
        setState(() {
          data = cv.list;
        });

        if (email.text.isNotEmpty &&
            password.text.isNotEmpty &&
            data.isNotEmpty) {
          for (int i = 0; i < data.length; i++) {
            if (email.text == data[i].email &&
                password.text == data[i].password) {
              remember = true;
              SharedPreference.Save_Infor(password.text, email.text, remember);
              final token = await FirebaseMessaging.instance.getToken();
              print(token);
              Update update = Update();
              update.UpdateData({"token": token}, "change_token/${data[i].id}");
              Get.off(() => HomePage(data: data[i]));
            }
          }
        }
      } else if (remember == true) {
        await cv.fetchData();
        setState(() {
          data = cv.list;
        });

        if (email.text.isNotEmpty &&
            password.text.isNotEmpty &&
            data.isNotEmpty) {
          for (int i = 0; i < data.length; i++) {
            if (email.text == data[i].email &&
                password.text == data[i].password) {
              remember = true;
              SharedPreference.Save_Infor(password.text, email.text, remember);
              Get.off(() => HomePage(data: data[i]));
            }
          }
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
      }
    } catch (e) {
      print(e);
    }
  }
}
