import 'package:btl/data/data.dart';
import 'package:btl/data/update.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Delivering extends StatefulWidget {
  List<Mua> mua;
  Data data;
  Delivering(this.mua, this.data);
  State<Delivering> createState() => _Delivering();
}

class _Delivering extends State<Delivering> {
  int tientong = 0;
  List<Mua> selectedItems = [];
  late List<bool> isSelected;
  void updateTotalAmount() {
    int total = 0;
    for (int i = 0; i < widget.mua.length; i++) {
      if (isSelected[i]) {
        total += int.parse(widget.mua[i].tien!) * widget.mua[i].soluong!;
      }
    }
    setState(() {
      tientong = total;
    });
  }

  void initState() {
    super.initState();
    isSelected = List.generate(widget.mua.length, (index) => false);
  }

  void SelectedItems() {
    List<Mua> selectedItem = [];
    for (int i = 0; i < widget.mua.length; i++) {
      if (isSelected[i]) {
        selectedItem.add(widget.mua[i]);
      }
    }
    setState(() {
      selectedItems = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.mua.length,
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
                  "${tientong}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                    onTap: () {
                      Update update = Update();
                      for (int i = 0; i < selectedItems.length; i++) {
                        update.UpdateData({"trangthai": 2},
                            "change_trangthai/${selectedItems[i].ngaymua}");
                      }
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Hoàn Tất Đơn Hàng Thành Công"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Đóng"))
                              ],
                            );
                          });
                    },
                    child: Container(
                      height: double.infinity,
                      width: 150,
                      color: Colors.amber,
                      child: Center(
                          child: Text("Xác Nhận Giao Hàng Thành Công",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                    ))
              ],
            ),
          ))
    ]);
  }
}
