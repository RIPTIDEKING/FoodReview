import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/product_title.dart';
import '../scoped-models/main.dart';
import '../models/Product.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final Product product = model.selectedProduct;

      return WillPopScope(
        onWillPop: () {
          model.deSelectIndex();
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(product.image),
                ProductTitle(product.title),
                Container(
                  margin: EdgeInsets.only(left: 5.0, right: 10.0),
                  child: Text(
                    'NeemKaThana, Rajasthan | ' +
                        "\u20B9 " +
                        product.price.toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Oswald',
                        color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    product.description,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  //   RaisedButton(
  //   child: Text('DELETE'),
  //   onPressed: () {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Are You Sure'),
  //             content: Text('This can\'t be undone'),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text('Cancel'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               FlatButton(
  //                 child: Text('Continue'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   Navigator.pop(context, true);
  //                 },
  //               )
  //             ],
  //           );
  //         });
  //   },
  // )
}
