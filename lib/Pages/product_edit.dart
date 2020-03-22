import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../commonValues/orienValue.dart';
import '../models/Product.dart';
import '../scoped-models/main.dart';

class ProducteditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProducteditPage();
  }
}

class _ProducteditPage extends State<ProducteditPage> {
  final Map<String, dynamic> _formData = {
    'id': null,
    'title': null,
    'image':
        'https://www.bbcgoodfood.com/sites/default/files/recipe/recipe-image/2019/05/chocolate-sponge-cake.jpg',
    'description': null,
    'price': null
  };
  bool _acceptTerms = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildTextFieldName(Product prod) {
    return TextFormField(
      initialValue: prod == null ? '' : prod.title,
      validator: (String value) {
        if (value.trim().isEmpty) {
          return 'Title is Required';
        }
      },
      decoration: InputDecoration(labelText: 'Product Title'),
      onSaved: (String input) {
        _formData['title'] = input;
      },
    );
  }

  Widget _buildTextFieldDescription(Product prod) {
    return TextFormField(
      initialValue: prod == null ? '' : prod.description,
      validator: (String value) {
        if (value.trim().isEmpty) {
          return 'There should be a description';
        }
        if (value.trim().length < 10) {
          return 'description is too short must be 10+ chracter';
        }
      },
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Description'),
      onSaved: (String input) {
        _formData['description'] = input;
      },
    );
  }

  Widget _buildTextFieldRate(Product prod) {
    return TextFormField(
      initialValue: prod == null ? '' : prod.price.toString(),
      validator: (String value) {
        if (value.trim().isEmpty) {
          return 'Nothing is Free plz add a value';
        }
        if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'prize should be a number';
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      onSaved: (String input) {
        _formData['price'] = double.parse(input);
      },
    );
  }

  Widget _buildSwitchListTile() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        _acceptTerms = value;
      },
      title: Text('Accept Terms'),
    );
  }

  Widget _buildRaisedButton(Product prod, Function addProd, Function updateProd,
      Function deSelectIndex, MainModel model) {
    return model.isLoading
        ? Center(child: CircularProgressIndicator())
        : RaisedButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text(prod == null ? 'Add Product' : 'save Product'),
            onPressed: () {
              if (!_formkey.currentState.validate()) {
                return;
              }
              _formkey.currentState.save();
              if (prod == null) {
                addProd(
                  _formData['title'],
                  _formData['description'],
                  _formData['image'],
                  _formData['price'],
                ).then((_) {
                  Navigator.pushReplacementNamed(context, '/auth').then((_) {
                    deSelectIndex();
                  });
                });
              } else {
                updateProd(
                  _formData['title'],
                  _formData['description'],
                  _formData['image'],
                  _formData['price'],
                ).then((_) {
                  Navigator.pushReplacementNamed(context, '/auth').then((_) {
                    deSelectIndex();
                  });
                });
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext contextt, Widget child, MainModel model) {
      final Widget producteditpage = GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: OrienValue(context).dewWidth(2)),
              children: <Widget>[
                _buildTextFieldName(model.selectedProduct),
                _buildTextFieldDescription(model.selectedProduct),
                _buildTextFieldRate(model.selectedProduct),
                _buildSwitchListTile(),
                SizedBox(
                  height: 5.0,
                ),
                _buildRaisedButton(model.selectedProduct, model.addProduct,
                    model.updateProduct, model.deSelectIndex, model)
                // GestureDetector(
                //   onLongPress: _onSubmit,
                //   child: Container(
                //     child: Center(child: Text('data')),
                //     color: Colors.green,
                //     padding: EdgeInsets.all(5.0),
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
      return model.selectedProduct == null
          ? producteditpage
          : WillPopScope(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: producteditpage,
              ),
              onWillPop: () {
                model.deSelectIndex();
                Navigator.pop(context, false);
                return Future.value(false);
              });
    });
  }
}
// Center(
//       child: RaisedButton(
//         child: Text('Save'),
//         onPressed: () {
//           showModalBottomSheet(
//               context: context,
//               builder: (BuildContext context) {
//                 return Center(child: Text('This is a Model Bottom Sheet!'));
//               });
//         },
//       ),
//     );
