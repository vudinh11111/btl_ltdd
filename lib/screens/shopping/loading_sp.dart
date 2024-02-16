import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Loading_sp extends StatefulWidget {
  List<Mua> mua;
  Data data;
  Loading_sp(this.mua, this.data);
  State<Loading_sp> createState() => _Loading_sp();
}

class _Loading_sp extends State<Loading_sp> {
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
                      onTap: () {},
                    ),
                  ]),
            ),
          );
        },
      ),
    ]);
  }
}
