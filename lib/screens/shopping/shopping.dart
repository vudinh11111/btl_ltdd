import 'package:btl/data/data.dart';
import 'package:btl/data/delete.dart';
import 'package:btl/paypal/paypal_screens.dart';

import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

class Shopping extends StatefulWidget {
  final List<GioHang> giohang;
  final Data data;

  Shopping(this.giohang, this.data);

  @override
  State<Shopping> createState() => _Shopping();
}

class _Shopping extends State<Shopping> {
  int tientong = 0;
  late List<bool> isSelected;
  List<GioHang> selectedItems = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.giohang.length, (index) => false);
  }

  void SelectedItems() {
    List<GioHang> selectedItem = [];
    for (int i = 0; i < widget.giohang.length; i++) {
      if (isSelected[i]) {
        selectedItem.add(widget.giohang[i]);
      }
    }
    setState(() {
      selectedItems = selectedItem;
    });
  }

  void updateTotalAmount() {
    int total = 0;
    for (int i = 0; i < widget.giohang.length; i++) {
      if (isSelected[i]) {
        total +=
            int.parse(widget.giohang[i].tien!) * widget.giohang[i].soluong!;
      }
    }
    setState(() {
      tientong = total;
    });
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.giohang.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isSelected[index] = !isSelected[index];
                  updateTotalAmount();
                  SelectedItems();
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
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Icon(
                                    Icons.check_circle,
                                    color: isSelected[index]
                                        ? Color.fromARGB(255, 0, 241, 60)
                                        : const Color.fromARGB(
                                            255, 218, 207, 174),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: GestureDetector(
                              child: ListTile(
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(
                                              "Bạn chắc chắn muốn xóa sản phẩm khỏi giỏ hàng chứ?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Hủy"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                );

                                                final _delete = Delete();
                                                await _delete.deleteData(
                                                  "${widget.giohang[index].ngaymua}",
                                                  "giohang",
                                                );
                                                setState(() {
                                                  widget.giohang
                                                      .removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Đồng ý"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartHome(
                                        widget.giohang[index],
                                        widget.data,
                                      ),
                                    ),
                                  );
                                },
                                leading: Image.network(
                                  '${widget.giohang[index].chooseImage}',
                                  fit: BoxFit.fill,
                                ),
                                title: Text("${widget.giohang[index].name}"),
                                subtitle: Text(
                                    "Số lượng: ${widget.giohang[index].soluong}"),
                              ),
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
                Text(
                  "Tổng: ${tientong}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    print(selectedItems);
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          child: Center(
                              child: Address(
                                  tientong, selectedItems, widget.data)),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: double.infinity,
                    width: 150,
                    color: Colors.amber,
                    child: Center(
                      child: Text(
                        "Thanh Toán",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
