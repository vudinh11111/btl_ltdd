import 'package:btl/data/data.dart';
import 'package:btl/data/post_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartChoose extends StatefulWidget {
  Product product;
  Data data;
  CartChoose(this.product, this.data);

  @override
  _CartChooseState createState() => _CartChooseState();
}

class _CartChooseState extends State<CartChoose> {
  int number = 1;
  List<bool> isSelectedImage = List<bool>.generate(50, (index) => false);
  List<bool> isSelectedSize = List<bool>.generate(50, (index) => false);
  String selectedImage = '';
  String selectedSize = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: widget.product.image!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 3,
                mainAxisSpacing: 2,
                mainAxisExtent: 80,
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Khi ảnh được nhấn vào
                      for (int i = 0; i < isSelectedImage.length; i++) {
                        if (i == index) {
                          // Nếu là ảnh được nhấn, đặt isSelected[index] là true
                          selectedImage = "${widget.product.image![index]}";
                          isSelectedImage[index] = true;
                        } else {
                          // Nếu không phải ảnh được nhấn, đặt isSelected[i] là false
                          isSelectedImage[i] = false;
                        }
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      Image.network(
                        "${widget.product.image![index]}",
                        fit: BoxFit.fill,
                      ),
                      if (isSelectedImage[index])
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(Icons.check_circle,
                              color: Color.fromARGB(255, 0, 255, 60)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          Text("Size:"),
          Expanded(
            child: GridView.builder(
              itemCount: widget.product.size!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 3,
                mainAxisSpacing: 2,
                mainAxisExtent: 30,
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < isSelectedSize.length; i++) {
                          if (i == index) {
                            // Nếu là ảnh được nhấn, đặt isSelected[index] là true
                            selectedSize = "${widget.product.size![index]}";
                            isSelectedSize[index] = true;
                          } else {
                            // Nếu không phải ảnh được nhấn, đặt isSelected[i] là false
                            isSelectedSize[i] = false;
                          }
                        }
                      });
                    },
                    child: Stack(children: [
                      Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary),
                          child: Center(
                              child: Text(
                            "${widget.product.size![index]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      if (isSelectedSize[index])
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(Icons.check_circle,
                              color: Color.fromARGB(255, 0, 241, 60)),
                        ),
                    ]));
              },
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (number > 1) number = number - 1;
                  });
                },
                child: Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "[   ${number}   ]",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    number = number + 1;
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 16),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text("Thêm"),
                      onPressed: () async {
                        Navigator.of(context).pop(null);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Đã Thêm Vào Giỏ"),
                                actions: [
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });

                        PostTakeData postTake = PostTakeData();
                        await postTake.post_take_data({
                          "product_id": widget.product.product_id,
                          "nguoimua": widget.data.id,
                          "soluong": number,
                          "chooseSize": selectedSize,
                          "chooseColor": "",
                          "chooseImage": selectedImage,
                        }, "giohang");
                      },
                    ),
                    TextButton(
                      child: Text("Hủy"),
                      onPressed: () {
                        Navigator.of(context).pop(null);
                      },
                    ),
                  ])),
        ],
      ),
    );
  }
}
