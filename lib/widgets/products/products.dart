import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../scoped-models/main.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Products> {
  @override
  void initState() {
    //widget.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
        return ProductCard(index);
        },
        itemCount: model.displayedList.length,
      );
    });
  }
}
