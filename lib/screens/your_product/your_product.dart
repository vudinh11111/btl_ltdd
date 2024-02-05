import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Your_Product extends StatefulWidget {
  List<Mua> mua;
  Data data;
  Your_Product(this.mua, this.data);
  State<Your_Product> createState() => _Your_Product();
}

class _Your_Product extends State<Your_Product> {
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartHome(
                                      widget.mua[index], widget.data)));
                        },
                        leading: Image.network(
                            fit: BoxFit.fill,
                            '${widget.mua[index].chooseImage}'),
                        title: Text("${widget.mua[index].tien}"),
                      ),
                      onTap: () {},
                    ),
                  ]),
            ),
          );
        },
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng:400.000vnđ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: double.infinity,
                      width: 150,
                      color: Colors.amber,
                      child: Center(
                          child: Text("Xác Nhận",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                    ))
              ],
            ),
          ))
    ]);
  }
}
