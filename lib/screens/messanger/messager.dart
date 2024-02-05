import 'package:btl/changenotifer/changenotifier.dart';
import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';
import 'package:btl/screens/messanger/chat_messager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Messanger extends StatefulWidget {
  Data data;
  Messanger(this.data);
  State<Messanger> createState() => _Messanger();
}

class _Messanger extends State<Messanger> {
  late ConvertData cv = ConvertData();
  List<Data> id_other = [];

  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    await cv.fetchData();
    await cv.fetchMessId(widget.data.id!);
    if (mounted)
      setState(() {
        cv.list.forEach((element) {
          cv.messid.forEach((item) {
            if (element.id == item && element.id != widget.data.id) {
              id_other.add(element);
            }
          });
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: id_other.length,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.02,
                        color: Theme.of(context).colorScheme.onSurface)),
                child: GestureDetector(
                    onTap: () {
                      if (mounted)
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Chat_Messanger(widget.data, id_other[index]);
                        }));
                    },
                    child: ListTile(
                        title: Text(
                          "${id_other[index].name}",
                          style: TextStyle(
                              color: context.watch<themeChange>().themedata ==
                                      "LightTheme"
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(id_other[index].avatar!),
                        ))));
          }),
    );
  }
}
