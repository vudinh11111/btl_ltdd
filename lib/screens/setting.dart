import 'package:btl/auth/shared_preferences.dart';
import 'package:btl/changenotifer/changenotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _TestState();
}

class _TestState extends State<Setting> {
  bool gido = false;
  late String selectedValue;
  String offoron = "off";

  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(child: Text("LightTheme"), value: "LightTheme"),
      DropdownMenuItem(child: Text("DarkTheme"), value: "DarkTheme"),
    ];
  }

  @override
  void initState() {
    setState(() {
      selectedValue = themevl;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Text(
                "Change Theme Light or Dark",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                value: selectedValue,
                items: dropdownItems,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    context.read<themeChange>().ChangeTheme(selectedValue);
                    SharedPreference.SaveTheme(selectedValue);
                  });
                },
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Text(
                "Danh hiệu mua của Tuần",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Switch(
                value: gido,
                onChanged: (value) {
                  setState(() {
                    gido = value;
                    if (gido == true) {
                      offoron = "on";
                    } else {
                      offoron = "off";
                    }
                  });
                },
              ),
              Text("${offoron}"),
            ]),
          ],
        ),
      ),
    );
  }
}
