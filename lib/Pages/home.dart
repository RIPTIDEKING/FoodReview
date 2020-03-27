import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

class HomePage extends StatefulWidget {
  final MainModel mainModel;

  HomePage(this.mainModel);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.mainModel.fetchProduct();
    super.initState();
  }

  Widget _buildProductList() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget returnWid =
          Center(child: Text("No Products Found. Please Add Some......."));
      if (model.displayedList.length > 0 && !model.isLoading) {
        returnWid = Products();
      } else if (model.isLoading) {
        returnWid = Center(
          child: CircularProgressIndicator(),
        );
      }

      return RefreshIndicator(child: returnWid, onRefresh:(){return model.fetchProduct(indicator: false);} ) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/manage_product');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Easy List'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(model.displayFavOnly
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                model.toggleDisplayMode();
              },
            );
          })
        ],
      ),
      body: _buildProductList(),
    );
  }
}
