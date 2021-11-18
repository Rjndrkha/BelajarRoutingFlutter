import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  final String url = 'http://127.0.0.1:8000/api/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Mart'),
      ),
      body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180,
                      child: Card(
                          elevation: 15,
                          child: Row(children: [
                            Container(
                              height: 120,
                              width: 120,
                              padding: EdgeInsets.all(5),
                              child: Image.network(
                                snapshot.data['data'][index]['image_url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data['data'][index]
                                      ['description']),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.edit),
                                      Text(snapshot.data['data'][index]['harga']
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ])),
                    );
                  });
            } else {
              return Text('Data Error');
            }
          }),
    );
  }
}
