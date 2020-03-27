import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../../Pages/product.dart';
import './price_tag.dart';
import './product_title.dart';
import '../../models/Product.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatefulWidget {
  final int index;
  ProductCard(this.index);
  @override
  State<StatefulWidget> createState() {
    return _ProductCard();
  }
}

class _ProductCard extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final List<Product> product = model.displayedList;
      return Card(
        child: Column(
          children: <Widget>[
            FadeInImage(
              height: 300.0,
              fit: BoxFit.cover,
              image: NetworkImage(product[widget.index].image),
              placeholder: AssetImage('assets/imageLoder.gif'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ProductTitle(product[widget.index].title),
                  PriceTag('\u20B9 ' + product[widget.index].price.toString())
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                child: Text('NeemKaThana, Rajasthan'),
              ),
            ),
            Text(product[widget.index].userEmail),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.info),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        model.selectIndex(widget.index);
                        return ProductPage();
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: model.displayedList[widget.index].isFavrouite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      model.selectIndex(widget.index);
                      model.toggleFavStatus();
                    });
                  },
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
