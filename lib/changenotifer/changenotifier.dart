import 'package:flutter/material.dart';

class numberShopping extends ChangeNotifier {
  int i = 0;
  void increment() {
    i = i + 1;
    notifyListeners();
  }
}

class numberNotification extends ChangeNotifier {
  int n = 0;
  void increment() {
    n = n + 1;
    notifyListeners();
  }
}

String themevl = 'LightTheme';

class themeChange extends ChangeNotifier {
  String themedata = themevl;
  void ChangeTheme(String n) {
    themedata = n;

    notifyListeners();
  }
}

class Seacher_image extends ChangeNotifier {
  int sapxep = 0;
  void ChangetuThap() {
    sapxep = 1;
    print("tu thap den cao");

    notifyListeners();
  }

  void ChangetuCao() {
    sapxep = 2;
    print("tu cao den thap");
    notifyListeners();
  }

  void Changebegin() {
    sapxep = 0;
    print("Khong sap xep");
    notifyListeners();
  }
}
