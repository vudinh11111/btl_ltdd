import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Product_manager extends StatefulWidget {
  List<Product> quanlisanpham;
  Data data;
  Product_manager(this.quanlisanpham, this.data);
  State<Product_manager> createState() => _Product_manager();
}

class _Product_manager extends State<Product_manager> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.quanlisanpham.length,
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
                                      widget.quanlisanpham[index],
                                      widget.data)));
                        },
                        leading: Image.network(
                            fit: BoxFit.fill,
                            '${widget.quanlisanpham[index].image![0]}'),
                        title: Text("${widget.quanlisanpham[index].tien}"),
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
