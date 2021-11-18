import 'package:onlinemart/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onlinemart/screen/add_product.dart';
import 'package:onlinemart/screen/edit_product.dart';
import 'dart:convert';
import 'package:onlinemart/components/color.dart';

import 'package:onlinemart/screen/product_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  final String url = 'http://127.0.0.1:8000/api/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // ignore: avoid_print
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Icon(Icons.add),
      ),
      appBar: buildAppBar(),
      body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 180,
                      child: Card(
                          elevation: 15,
                          child: Row(children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              product: snapshot.data['data']
                                                  [index],
                                            )));
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  snapshot.data['data'][index]['image_url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['name'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data['data'][index]
                                          ['description']),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProduct(
                                                            product: snapshot
                                                                    .data[
                                                                'data'][index],
                                                          )));
                                            },
                                            child: const Icon(Icons.edit)),
                                        Text(snapshot.data['data'][index]
                                                ['harga']
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ])),
                    );
                  });
            } else {
              return const Text('Data Error');
            }
          }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: kTextColor,
        onPressed: () {},
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
