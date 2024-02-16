import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Purchase_historyY extends StatefulWidget {
  List<Mua> mua;
  Data data;
  Purchase_historyY(this.mua, this.data);
  State<Purchase_historyY> createState() => _You_cart();
}

class _You_cart extends State<Purchase_historyY> {
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.mua.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: ListTile(
                        trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "số điện thoại:${widget.mua[index].sodienthoai}"),
                              Text("địa chỉ:${widget.mua[index].diachi}"),
                              Text(
                                  "tên người nhận:${widget.mua[index].nameid}"),
                            ]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartHome(
                                widget.mua[index],
                                widget.data,
                              ),
                            ),
                          );
                        },
                        leading: Image.network(
                          fit: BoxFit.fill,
                          '${widget.mua[index].chooseImage}',
                        ),
                        title: Text("${widget.mua[index].name}"),
                        subtitle:
                            Text("Số lượng: ${widget.mua[index].soluong}"),
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    ]);
  }
}
