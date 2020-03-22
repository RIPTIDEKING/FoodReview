import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addPro;

  ProductControl(this.addPro);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        addPro({'title': 'chocolate', 'image': 'assets/wd2.png'});
      },
      child: Text('Add Product'),
    );
  }
}
