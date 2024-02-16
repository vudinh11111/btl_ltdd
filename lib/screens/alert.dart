import 'package:btl/data/data.dart';
import 'package:flutter/material.dart';

class Alert {
  static void showMenuNotifications(
      BuildContext context, List<Notifier> notifier) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 100, 10, 100),
        items: [
          PopupMenuItem(
            enabled: false,
            child: Column(children: [
              Text("Thông báo từ hệ thống"),
              Container(
                height: 200,
                width: 150,
                child: ListView.builder(
                    itemCount: notifier.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Thông báo từ hệ thống",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                      child: Text(
                                    "${notifier[index].notifier}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ]),
                              );
                            },
                          );
                        },
                        title: Text(
                          "${notifier[index].notifier}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    })),
              ),
            ]),
          ),
        ]).then((value) {});
  }
}
