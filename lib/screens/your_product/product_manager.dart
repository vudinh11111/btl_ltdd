import 'package:btl/data/data.dart';
//import 'package:btl/data/delete.dart';
//import 'package:btl/google_drive/ggdriver.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.quanlisanpham.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // isSelected[index] = !isSelected[index];

                //  SelectedItems();
              });
            },
            child: Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 20,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartHome(
                                    widget.quanlisanpham[index],
                                    widget.data,
                                  ),
                                ),
                              );
                            },
                            leading: Image.network(
                              fit: BoxFit.fill,
                              '${widget.quanlisanpham[index].image![0]}',
                            ),
                            title: Text("${widget.quanlisanpham[index].name}"),
                            subtitle: Text(
                                "id:${widget.quanlisanpham[index].product_id}"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                Expanded(
                  child: Text(
                    "Bạn treo bán ${widget.quanlisanpham.length} sản phẩm",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                // Expanded(
                //   child: ElevatedButton(
                //      onPressed: () async {
                // Delete delete = Delete();
                // GoogleApiDr googleApiDr = GoogleApiDr();
                //for (int i = 0; i < selectedItems.length; i++) {
                //  await delete.deleteData(
                //     "${selectedItems[i].product_id}", "sanpham");

                // await googleApiDr.DeleteFilesByName(
                //    selectedItems[i].name!);
                // }
                // },
                //child: Text(
                // "Xóa",
                //  style: TextStyle(color: Colors.amber),
                //)
                //)
                // ),
              ],
            ),
          ))
    ]);
  }
}
