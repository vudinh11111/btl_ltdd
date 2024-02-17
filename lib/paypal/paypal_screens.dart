import 'package:btl/data/data.dart';
import 'package:btl/data/post_data.dart';
import 'package:btl/paypal/flutter_paypal.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Paypal extends StatefulWidget {
  int tien;
  List<GioHang> giohangsangmua;
  String diachi;
  Data data;
  Paypal(this.tien, this.giohangsangmua, this.diachi, this.data);
  @override
  State<Paypal> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Paypal> {
  String tatca = "";
  void tatcasp() {
    for (int i = 0; i < widget.giohangsangmua.length; i++) {
      tatca = tatca + widget.giohangsangmua[i].name! + " ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Trang thanh toán")),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
                onPressed: () async {
                  DateTime dta = DateTime.now();
                  PostTakeData postTake = PostTakeData();

                  for (int i = 0; i < widget.giohangsangmua.length; i++) {
                    await postTake.post_take_data({
                      "soluong": widget.giohangsangmua[i].soluong,
                      "product_id": widget.giohangsangmua[i].product_id,
                      "nguoimua": widget.data.id,
                      "diachi": widget.diachi,
                      "trangthai": 0,
                      "nguoigiao": "",
                      "ngaygiao": "",
                      "ngaymua": "${dta}",
                    }, "mua");
                  }
                  print("onSuccess");
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    height: 50,
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Center(
                        child: Text(
                      "Trả khi nhận hàng<chỉ người Việt Nam>",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )))),
            TextButton(
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                            "ARiTSJHFCllGq-UZH7hXVNAzgCW5E6Od2Y6HHhUQ2gRa0IRFbYAm1ObrgD0vT2nxf4j97irSybKaexmb",
                        secretKey:
                            "EMg3fZJn20dhl3kIHxkccmDmmPnlvQ82FoeBMyq3rBLHOzaAEB6aice_XAQtVDvTLeajptE7AWfien4V",
                        returnURL: "https://sherlockhome.io.vn/return",
                        cancelURL: "https://sherlockhome.io.vn/cancel",
                        transactions: [
                          {
                            "amount": {
                              "total": '${widget.tien + 10}',
                              "currency": "USD",
                            },
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          DateTime dta = DateTime.now();
                          PostTakeData postTake = PostTakeData();

                          for (int i = 0;
                              i < widget.giohangsangmua.length;
                              i++) {
                            await postTake.post_take_data({
                              "soluong": widget.giohangsangmua[i].soluong,
                              "product_id": widget.giohangsangmua[i].product_id,
                              "nguoimua": widget.data.id,
                              "diachi": widget.diachi,
                              "trangthai": 0,
                              "nguoigiao": "",
                              "ngaygiao": "",
                              "ngaymua": "${dta}",
                            }, "mua");

                            await postTake.post_take_data({
                              "product_id": widget.giohangsangmua[i].product_id,
                              "nguoiban": widget.giohangsangmua[i].nguoiban,
                              "tien": widget.giohangsangmua[i].tien,
                              "soluong": widget.giohangsangmua[i].soluong,
                              "ngaymua": "${dta}",
                            }, "/phaitra");
                          }

                          print("onSuccess");
                        },
                        onError: (error) {
                          print("onError: $error");
                        },
                        onCancel: (params) {
                          print('cancelled: $params');
                        }),
                  ),
                )
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                      child: Text(
                    "Trả bằng Paypal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ))),
            )
          ]),
        ));
  }
}

// ignore: must_be_immutable
class Address extends StatefulWidget {
  int tien;
  List<GioHang> name;
  Data data;

  Address(this.tien, this.name, this.data);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController textdiachi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: textdiachi,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Nhập địa chỉ nhận hàng"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (textdiachi.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Paypal(widget.tien, widget.name,
                            textdiachi.text, widget.data),
                      ),
                    );
                  }
                },
                child: Text("next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
