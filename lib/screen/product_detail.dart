import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetail extends StatelessWidget {
  final Map product;

  const ProductDetail({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product Detail"),
        ),
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
}
