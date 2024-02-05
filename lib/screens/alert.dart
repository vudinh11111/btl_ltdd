import 'package:flutter/material.dart';

class Alert {
  static void showMenuNotifications(BuildContext context) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 100, 10, 100),
        items: [
          PopupMenuItem(
            enabled: false,
            child: Container(
              height: 200,
              width: 100,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () {
                        print("Hello");
                      },
                      title: Text("Hello"),
                    );
                  })),
            ),
          ),
        ]).then((value) {});
  }
}
