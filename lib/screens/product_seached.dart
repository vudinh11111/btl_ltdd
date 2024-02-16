import 'package:btl/changenotifer/changenotifier.dart';
import 'package:btl/data/convert_data.dart';
import 'package:btl/data/data.dart';
import 'package:btl/multi_dropdown/multi_dropdown.dart';
import 'package:btl/screens/cart_home/home_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Product_Searched extends StatefulWidget {
  String searchQuery;
  List<Product>? product;
  Data data;
  Product_Searched(this.searchQuery, this.data, {this.product});

  @override
  _ProductSearchedState createState() => _ProductSearchedState();
}

class _ProductSearchedState extends State<Product_Searched> {
  late List<Product> sortproduct;
  ConvertData cv = ConvertData();
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    sortproduct = List.from(widget.product!);
  }

  List<Widget> buildFilteredItemsList() {
    List<Widget> filteredItems = [];
    if (context.watch<Seacher_image>().sapxep == 0) {
      sortproduct = List.from(widget.product!);
    } else if (context.watch<Seacher_image>().sapxep == 1) {
      sortProductsByPrice(sortproduct);
    } else if (context.watch<Seacher_image>().sapxep == 2) {
      sortProductsByPricenguoc(sortproduct);
    }
    for (int index = 0; index < sortproduct.length; index++) {
      if (sortproduct[index]
          .name!
          .toLowerCase()
          .contains(widget.searchQuery.toLowerCase())) {
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
                        '${sortproduct[index].image![0]}',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartHome(sortproduct[index], widget.data),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${sortproduct[index].name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
        );
      }
    }

    return filteredItems;
  }

  List<Product> sortProductsByPrice(List<Product> productList) {
    productList
        .sort((a, b) => int.parse(a.tien!).compareTo(int.parse(b.tien!)));
    return productList;
  }

  List<Product> sortProductsByPricenguoc(List<Product> productList) {
    productList
        .sort((b, a) => int.parse(a.tien!).compareTo(int.parse(b.tien!)));

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          height: 40,
          child: Stack(children: [MultiDropdown()]),
          margin: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      Expanded(
          flex: 10,
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
    ]));
  }
}
