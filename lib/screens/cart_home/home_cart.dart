import 'dart:convert';

import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';

import 'package:btl/data/post_data.dart';
import 'package:btl/screens/cart_home/cart_choose.dart';
import 'package:btl/screens/cart_home/head_tab/head_tab_sp.dart';
import 'package:btl/screens/messanger/chat_messager.dart';
import 'package:btl/screens/shopping/tab_manage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CartHome extends StatefulWidget {
  dynamic product;
  Data data;

  CartHome(this.product, this.data);
  State<CartHome> createState() => _CartHome();
}

class _CartHome extends State<CartHome> {
  final ConvertData cv = ConvertData();
  TextEditingController binhluan = TextEditingController();
  late int luotthich;
  @override
  void initState() {
    super.initState();
    isFavoriteKo();
    luotthich = int.parse(widget.product.luotthich);
  }

  Future<void> fetch() async {
    await cv.fetchDataOth(widget.product.nguoiban!);
  }

  Future<void> fetchBl() async {
    await cv.fetchBinhLuan(widget.product.product_id);
  }

  Future<void> postComment() async {
    if (binhluan.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      PostTakeData post = PostTakeData();
      DateTime dt = DateTime.now();
      await post.post_take_data({
        "product_id": "${widget.product.product_id}",
        "timebinhluan": "${dt}",
        "messbl": "${binhluan.text}",
        "id": widget.data.id
      }, "binhluan");
      setState(() {});
      Navigator.pop(context);
      binhluan.clear();
      // Fetch comments again to refresh the list after posting
      await fetchBl();
    }
  }

  bool isFavorite = false;
  Future<void> isFavoriteKo() async {
    final url =
        'https://sherlockhome.io.vn/i/luotthich/${widget.product.product_id}/${widget.data.id}';
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> cv =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      List<Thich> convertData = [];
      for (int i = 0; i < cv.length; i++) {
        Thich data = Thich(
          product_id: cv[i]["product_id"] ?? "",
          id: cv[i]["id"] ?? "",
        );
        convertData.add(data);
      }
      if (convertData.isNotEmpty) {
        setState(() {
          isFavorite = true;
        });
      }

      print(isFavorite);
    } else {
      throw Exception("Lỗi FetchData");
    }
  }

  Future<void> deleteLuotThich(String id, String productId) async {
    const url =
        'https://sherlockhome.io.vn/i/luotthich'; // Thay đổi URL tương ứng với địa chỉ API của bạn
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'product_id': productId,
        }),
      );
      if (response.statusCode == 200) {
        print('Deleted successfully');
      } else {
        print('Failed to delete. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Shopping_cart(widget.data)),
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
      body: FutureBuilder(
          future: Future.wait([fetch(), fetchBl()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(children: [
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: HeadTapSp(widget.product.image!)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Text(
                            "Giá bán: ${widget.product.tien} USD",
                            style: TextStyle(fontSize: 25),
                          ),
                        ]),
                        SizedBox(
                          height: 5,
                        ),
                        SafeArea(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${widget.product.name}",
                                  style: TextStyle(fontSize: 19),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Lượt mua:${widget.product.luotmua}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            "Số lượt thích:${luotthich}",
                            style: TextStyle(fontSize: 14),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                                PostTakeData postdata = PostTakeData();

                                if (isFavorite == true) {
                                  postdata.post_take_data({
                                    "product_id":
                                        "${widget.product.product_id}",
                                    "id": "${widget.data.id}"
                                  }, "luotthich");
                                  setState(() {
                                    luotthich = luotthich + 1;
                                  });
                                } else {
                                  deleteLuotThich("${widget.data.id}",
                                      "${widget.product.product_id}");
                                  setState(() {
                                    if (luotthich > 0) {
                                      luotthich = luotthich - 1;
                                    }
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: isFavorite
                                  ? Colors.red
                                  : const Color.fromARGB(255, 101, 97, 97),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.02,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface)),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chat_Messanger(
                                              widget.data, cv.listOth!)));
                                },
                                child: ListTile(
                                    title: Text("Nhắn tin"),
                                    leading: CircleAvatar(
                                      backgroundImage: cv.listOth != null
                                          ? NetworkImage(
                                              '${cv.listOth!.avatar}')
                                          : AssetImage("assets/avatar0.jpg")
                                              as ImageProvider,
                                    )))),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("chi tiết:"),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("${widget.product.mieuta}"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Bình luận",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Column(
                                children: [
                                  TextField(
                                    controller: binhluan,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text("viết bình luận")),
                                    onSubmitted: (value) async {
                                      await postComment();
                                    },
                                  ),
                                  SizedBox(
                                    height: 300, // Adjust the height as needed
                                    child: ListView.builder(
                                        itemCount: cv.binhluan.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: cv.listOth !=
                                                      null
                                                  ? NetworkImage(
                                                      '${cv.binhluan[index].avatar}')
                                                  : AssetImage(
                                                          "assets/avatar0.jpg")
                                                      as ImageProvider,
                                            ),
                                            subtitle: Text(
                                                "${cv.binhluan[index].mess}"),
                                            title: Text(
                                                "${cv.binhluan[index].name}"),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ])
                      ]),
                ),
              ]);
            }
          }),
      bottomNavigationBar: Container(
        height: 50,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 11,
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 1,
                      child: Center(
                        child: CartChoose(widget.product, widget.data),
                      ),
                    );
                  },
                );
              },
              child: Text(
                "Thêm vào giỏ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
        width: double.infinity,
        color: Color.fromARGB(255, 98, 194, 238),
      ),
    );
  }
}
