import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Delivering_sp extends StatefulWidget {
  List<Mua> mua;
  Data data;
  Delivering_sp(this.mua, this.data);
  State<Delivering_sp> createState() => _Delivering_sp();
}

class _Delivering_sp extends State<Delivering_sp> {
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
              ],
            ),
          ))
    ]);
  }
}
