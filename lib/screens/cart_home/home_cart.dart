import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/cart_choose.dart';
import 'package:btl/screens/cart_home/head_tab/head_tab_sp.dart';
import 'package:btl/screens/messanger/chat_messager.dart';
import 'package:btl/screens/shopping/tab_manage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartHome extends StatefulWidget {
  dynamic product;
  Data data;

  CartHome(this.product, this.data);
  State<CartHome> createState() => _CartHome();
}

class _CartHome extends State<CartHome> {
  final ConvertData cv = ConvertData();

  Future<void> fetch() async {
    await cv.fetchDataOth(widget.product.nguoiban!);
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
            future: fetch(),
            builder: (context, snap) {
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
                            "${widget.product.tien}",
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
                            "Số lượt thích:${widget.product.luotthich}",
                            style: TextStyle(fontSize: 14),
                          ),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("viết bình luận")),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 11,
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1,
                                      child: Center(
                                          child: CartChoose(
                                              widget.product, widget.data)),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Thêm vào giỏ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          /*
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber)),
                          onPressed: () {},
                          child: Text(
                            "Mua",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                    */
                        ]),
                    width: double.infinity,
                    color: Color.fromARGB(255, 98, 194, 238),
                  ),
                )
              ]);
            }));
  }
}
