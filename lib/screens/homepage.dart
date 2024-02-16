import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:btl/auth/shared_preferences.dart';
import 'package:btl/changenotifer/changenotifier.dart';
import 'package:btl/data/convert_data.dart';
import 'package:btl/screens/home_best.dart';
import 'package:btl/screens/product_seached.dart';
import 'package:btl/screens/seacher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:btl/data/data.dart';
import 'package:get/get.dart';
import 'package:btl/screens/messanger/messager.dart';
import 'package:btl/screens/shopping/tab_manage.dart';
import 'package:btl/screens/your_product/tab_manage.dart';
import 'package:flutter/material.dart';
import 'package:btl/screens/alert.dart';
import 'setting.dart';

import 'package:btl/screens/change_image/change_image.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  Data? data;

  HomePage({this.data});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  ConvertData cv = ConvertData();
  late List<Product> sortproduct = [];
  List<int> manager = [0];
  String searchQuery = '';

  int numberpage = 0;

  TextEditingController _textControll = TextEditingController();
  // ConvertData cv = ConvertData();

  final _scaffold = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController(initialPage: 0);
  late IO.Socket socketUser;
  void connectToSockets() {
    socketUser = IO.io(
      'https://sherlockhome.io.vn',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socketUser.connect();
    socketUser.on('messager', (data) {
      if (this.mounted)
        setState(() {
          showNotification(data["mess"], data["id_receiver"], data["name"],
              data["id_sender"]);
        });
    });
  }

  Future showNotification(dynamic message, dynamic idReceiver, dynamic name,
      dynamic idSender) async {
    if (idReceiver == widget.data!.id) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'chat_channel',
          title: '${name}',
          body: message,
        ),
      );
    }
  }

  void Sign_Out() async {
    Get.offAndToNamed("/login");
    final share_auth = await SharedPreferences.getInstance();
    share_auth.remove("email");
    share_auth.remove("remember");
    share_auth.remove("password");
  }

  void page_controller(int number_page) {
    setState(() {
      if (number_page < 4) {
        manager[0] = number_page;
      } else {
        if (!manager.contains(number_page)) {
          manager.add(number_page);
        }
      }

      numberpage = number_page;
      _pageController.jumpToPage(number_page);
      print(manager);
    });
  }

  void openDrawer() async {
    _scaffold.currentState!.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    connectToSockets();
    cv.fetchnotifier();
  }

/*
  Future fetch() async {
    await cv.fetchduct();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  "${widget.data!.name}",
                  style: TextStyle(
                      color:
                          context.watch<themeChange>().themedata == "LightTheme"
                              ? Colors.black
                              : Colors.white),
                ),
                accountEmail: Text(
                  "${widget.data!.email}",
                  style: TextStyle(
                      color:
                          context.watch<themeChange>().themedata == "LightTheme"
                              ? Colors.black
                              : Colors.white),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Change_Image(
                              widget.data!.avatar!,
                              widget.data!,
                              () => page_controller(numberpage))),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                          child: CircleAvatar(
                              radius: 40,
                              backgroundImage: widget.data!.avatar != ""
                                  ? NetworkImage(widget.data!.avatar!)
                                  : AssetImage("assets/avatar0.jpg")
                                      as ImageProvider)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                currentAccountPictureSize: const Size.square(80),
                decoration: const BoxDecoration(),
              ),
              ListTile(
                title: const Text('Home'),
                selected: numberpage == 0,
                onTap: () {
                  page_controller(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Stack(children: [
                  Text("Tin Nhắn"),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 250, 0, 0)),
                      ))
                ]),
                selected: numberpage == 1,
                onTap: () {
                  page_controller(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cài Đặt'),
                selected: numberpage == 2,
                onTap: () async {
                  themevl = await SharedPreference.GetTheme();
                  page_controller(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Bán đồ'),
                selected: numberpage == 3,
                onTap: () {
                  page_controller(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Đăng xuất'),
                onTap: () {
                  Navigator.pop(context);
                  Sign_Out();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: numberpage >= 4
              ? IconButton(
                  icon: Icon(Icons.navigate_before),
                  onPressed: () {
                    if (mounted && manager.length >= 2) {
                      page_controller(manager[manager.length - 2]);
                      manager.remove(manager[manager.length - 1]);

                      if (manager[manager.length - 1] < 4) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          searchQuery = '';
                          _textControll.clear();
                        });
                      }

                      print(manager);
                    }
                  },
                )
              : IconButton(
                  onPressed: openDrawer,
                  icon: Stack(children: [
                    Icon(Icons.menu),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 250, 0, 0)),
                        ))
                  ]),
                ),
          actions: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 52, top: 10, bottom: 10),
                    child: TextField(
                        textInputAction: TextInputAction.done,
                        onTap: () {
                          page_controller(4);
                        },
                        cursorColor: Colors.amber,
                        controller: _textControll,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(),
                          hintText: "Search",
                          icon: Icon(
                            Icons.search,
                            size: 18,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                          print(searchQuery);
                          if (value.isNotEmpty) {
                            page_controller(5);
                          }
                        }))),
            IconButton(
              onPressed: () {
                Alert.showMenuNotifications(context, cv.notifier);
              },
              icon: Stack(children: [
                Icon(Icons.add_alert),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 250, 0, 0)),
                    ))
              ]),
            ),
            IconButton(
              onPressed: () {
                if (mounted)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Shopping_cart(widget.data!)),
                  );
              },
              icon: Stack(children: [
                Icon(Icons.shopping_cart),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 250, 0, 0)),
                    ))
              ]),
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            FutureBuilder(
                future: cv.fetchductbest().then((value) {
                  cv.fetchduct();
                }),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: HomeBest(cv.bestproduct, widget.data!),
                      ))
                    ],
                  );
                }),
            Messanger(widget.data!),
            Setting(),
            Shopping_cartY(widget.data!),
            Seacher_SomeThing(),
            Product_Searched(
              searchQuery,
              widget.data!,
              product: cv.product,
            )
          ],
        ));
  }

  void dispose() {
    super.dispose();
    socketUser.disconnect();
  }
}
