import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';
import 'package:btl/screens/shopping/delivering_sp.dart';
import 'package:btl/screens/shopping/loading_sp.dart';
import 'package:btl/screens/shopping/purchase_history.dart';
import 'package:btl/screens/shopping/shopping.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Shopping_cart extends StatefulWidget {
  Data data;
  Shopping_cart(this.data);
  State<Shopping_cart> createState() => _Shopping_cart();
}

class _Shopping_cart extends State<Shopping_cart> {
  ConvertData cv = ConvertData();
  late List<Mua> lichsu = [];
  late List<Mua> doi = [];
  late List<Mua> danggiao = [];

  @override
  void initState() {
    super.initState();
  }

  Future fetch() async {
    lichsu = [];
    doi = [];
    danggiao = [];
    await cv.fetchgiohang(widget.data.id!);
    await cv.fetchmua(widget.data.id!);

    if (cv.mua.isNotEmpty) {
      for (int i = 0; i < cv.mua.length; i++) {
        if (cv.mua[i].trangthai == 0) {
          doi.add(cv.mua[i]);
        } else if (cv.mua[i].trangthai == 1) {
          danggiao.add(cv.mua[i]);
        } else if (cv.mua[i].trangthai == 2) {
          lichsu.add(cv.mua[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return DefaultTabController(
                  initialIndex: 0,
                  length: 4,
                  child: Scaffold(
                    body: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Theme.of(context).colorScheme.primary,
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: Colors.white,
                                  tabs: [
                                    Tab(
                                      text: "Giỏ hàng của bạn",
                                    ),
                                    Tab(
                                      text: "Đợi xác nhận hàng",
                                    ),
                                    Tab(
                                      text: "Đang Giao",
                                    ),
                                    Tab(
                                      text: "Lịch Sử Mua Hàng",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Shopping(cv.giohang, widget.data),
                              Loading_sp(doi, widget.data),
                              Delivering_sp(danggiao, widget.data),
                              Purchase_history(lichsu, widget.data)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  @override
  void dispose() {
    doi = [];
    lichsu = [];
    danggiao = [];
    super.dispose();
  }
}
