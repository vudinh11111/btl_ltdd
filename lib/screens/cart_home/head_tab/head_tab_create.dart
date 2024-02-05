import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeadTapCreate extends StatefulWidget {
  List<dynamic> image;
  HeadTapCreate(this.image);

  @override
  State<HeadTapCreate> createState() => _HeadTapCreate();
}

class _HeadTapCreate extends State<HeadTapCreate>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<Widget> _tabViewChildren = [];
  @override
  void initState() {
    for (int i = 0; i < widget.image.length; i++) {
      _tabViewChildren.add(Container(
          child: Image.file(
        File(widget.image[i]),
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
