import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import './product_edit.dart';
import '../models/Product.dart';
import '../scoped-models/main.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  initState() {
    widget.model.fetchProduct();
    super.initState();
  }

  Widget _builditemBuilder(BuildContext context, int index) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final List<Product> products = model.products;
      return Dismissible(
        key: Key(products[index].title),
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            model.selectIndex(index);
            model.removeProduct();
          }
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(products[index].image),
              ),
              title: Text(products[index].title),
              subtitle: Text('\$${products[index].price.toString()}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  model.selectIndex(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProducteditPage();
                      },
                    ),
                  );
                },
              ),
            ),
            Divider(),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final List<Product> products = model.products;
      return ListView.builder(
        itemBuilder: _builditemBuilder,
        itemCount: products.length,
      );
    });
  }
}
