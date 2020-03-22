import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget{
final String title;
ProductTitle(this.title);

  @override
    Widget build(BuildContext context) {
      return Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald'),
                  ),
                );
    }
}