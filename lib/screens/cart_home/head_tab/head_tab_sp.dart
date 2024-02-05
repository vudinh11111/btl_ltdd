import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeadTapSp extends StatefulWidget {
  List<dynamic> image;
  HeadTapSp(this.image);

  @override
  State<HeadTapSp> createState() => _HeadTapSp();
}

class _HeadTapSp extends State<HeadTapSp> with TickerProviderStateMixin {
  TabController? _tabController;
  List<Widget> _tabViewChildren = [];
  @override
  void initState() {
    for (int i = 0; i < widget.image.length; i++) {
      _tabViewChildren.add(Container(
          child: Image.network(
        "${widget.image[i]}",
        fit: BoxFit.fill,
      )));
    }
    _tabController =
        TabController(length: _tabViewChildren.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBarView(
          controller: _tabController,
          children: _tabViewChildren,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 20,
          child: Container(
            height: 100,
            color: Colors.black54,
            alignment: Alignment.center,
            child: TabPageSelector(
              controller: _tabController,
              indicatorSize: 20,
              selectedColor: Colors.white,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
