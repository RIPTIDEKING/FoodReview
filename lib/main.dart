import 'package:course_start/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:flutter/rendering.dart';

import './Pages/auth.dart';
import './Pages/manage_product.dart';
import './Pages/home.dart';
import './scoped-models/main.dart';

main() {
  // debugPaintBaselinesEnabled = true;
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State {
  final MainModel model = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          //  debugShowMaterialGrid: true,
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepOrange,
              buttonColor: Colors.deepPurple,
              accentColor: Colors.deepPurple),
          // home: AuthPage(),
          routes: {
            '/': (BuildContext context) => AuthPage(),
            '/auth': (BuildContext context) => HomePage(model),
            '/manage_product': (BuildContext context) => ManageProduct(model),
            '/product': (BuildContext context) => Products(),
          },
          // onGenerateRoute: (RouteSettings setting) {
          //   final List<String> pathElements = setting.name.split('/');
          //   if (pathElements[0] != "") {
          //     return null;
          //   }
          //   if (pathElements[1] == 'product') {
          //     final int index = int.parse(pathElements[2]);
          //     return MaterialPageRoute(
          //       builder: (BuildContext context) => ProductPage(
          //           _products[index]['title'], _products[index]['image']),
          //     );
          //   }
          // },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (BuildContext context) => HomePage(model));
          },
        ));
  }
}
