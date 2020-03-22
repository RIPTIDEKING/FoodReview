import 'package:course_start/scoped-models/main.dart';
import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';

class ManageProduct extends StatelessWidget {
  final MainModel model;
  ManageProduct(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/auth');
                },
                title: Text('All Products'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Products',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              )
            ],
          ),
          title: Text('Manage Products'),
        ),
        body: TabBarView(
          children: <Widget>[
            ProducteditPage(),
            ProductListPage(model)
          ],
        ),
      ),
    );
  }
}
