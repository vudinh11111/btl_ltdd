import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';
import 'package:btl/screens/your_product/create_product.dart';
import 'package:btl/screens/your_product/delivering.dart';
import 'package:btl/screens/your_product/product_manager.dart';
import 'package:btl/screens/your_product/sales_history.dart';
import 'package:btl/screens/your_product/your_product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Shopping_cartY extends StatefulWidget {
  Data data;
  Shopping_cartY(this.data);
  State<Shopping_cartY> createState() => _Shopping_cart();
}

class _Shopping_cart extends State<Shopping_cartY> {
  ConvertData cv = ConvertData();
  late List<Mua> lichsu;
  late List<Mua> doi;
  late List<Mua> danggiao;
  @override
  void initState() {
    super.initState();
  }

  Future fetch() async {
    lichsu = [];
    doi = [];
    danggiao = [];
    await cv.fetchqlsp(widget.data.id!);
    await cv.fetchgiohang(widget.data.id!);
    await cv.fetchban(widget.data.id!);
    if (cv.ban.isNotEmpty) {
      for (int i = 0; i < cv.ban.length; i++) {
        if (cv.ban[i].trangthai == 0) {
          doi.add(cv.ban[i]);
        } else if (cv.ban[i].trangthai == 1) {
          danggiao.add(cv.ban[i]);
        } else if (cv.ban[i].trangthai == 2) {
          lichsu.add(cv.ban[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return DefaultTabController(
                  initialIndex: 0,
                  length: 5,
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
                                      text: "Tạo hàng",
                                    ),
                                    Tab(
                                      text: "Đợi hàng",
                                    ),
                                    Tab(
                                      text: "Đang Giao",
                                    ),
                                    Tab(
                                      text: "Quản lí Sản Phẩm",
                                    ),
                                    Tab(
                                      text: "Lịch Sử Bán Hàng",
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
                              CreateProduct(widget.data),
                              Your_Product(doi, widget.data),
                              Delivering(danggiao, widget.data),
                              Product_manager(cv.quanlisanpham, widget.data),
                              Purchase_historyY(lichsu, widget.data)
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
