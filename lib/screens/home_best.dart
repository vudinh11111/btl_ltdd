import 'package:btl/data/data.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeBest extends StatefulWidget {
  List<Product> product;
  Data data;
  HomeBest(this.product, this.data);

  State<HomeBest> createState() => _HomeBest();
}

class _HomeBest extends State<HomeBest> {
  List<Widget> buildFilteredItemsList() {
    List<Widget> filteredItems = [];

    for (int index = 0; index < widget.product.length; index++) {
      filteredItems.add(
        Card(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    height: 150,
                    child: Image.network(
                      fit: BoxFit.fill,
                      '${widget.product[index].image![0]}',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CartHome(widget.product[index], widget.data),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  "${widget.product[index].name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return filteredItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Center(
              child: Text(
        "Phổ biến nhất",
        style: TextStyle(fontSize: 25),
      ))),
      Expanded(
          flex: 8,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: buildFilteredItemsList().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 4 * 50,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return buildFilteredItemsList()[index];
            },
          ))
    ]);
  }
}
