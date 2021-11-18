import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:onlinemart/components/color.dart';

class ProductDetail extends StatelessWidget {
  final Map product;

  const ProductDetail({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [
            Image.network(product['image_url']),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['harga'],
                    style: const TextStyle(fontSize: 22),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.edit),
                      Icon(Icons.delete),
                    ],
                  )
                ],
              ),
            ),
            Text(product['description']),
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: kTextColor,
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          // By default our  icon color is white
          color: kTextColor,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          // By default our  icon color is white
          color: kTextColor,
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
