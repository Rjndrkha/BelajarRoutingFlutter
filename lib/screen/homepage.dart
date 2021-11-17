import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  final String url = 'http://127.0.0.1:8000/api/products';

  getProducts() {
    var response = http.get(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Mart'),
      ),
    );
  }
}
