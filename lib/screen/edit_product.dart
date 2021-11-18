import 'package:onlinemart/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onlinemart/screen/add_product.dart';
import 'package:onlinemart/screen/edit_product.dart';
import 'dart:convert';

class EditProduct extends StatelessWidget {
  final Map product;

  EditProduct({@required this.product});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _imgController = TextEditingController();

  Future saveProduct() async {
    final response = await http.put(
        Uri.parse(
            "http://127.0.0.1:8000/api/products" + product['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _descontroller.text,
          "harga": _hargaController.text,
          "image_url": _imgController.text,
        });
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController..text = product['name'],
                decoration: InputDecoration(labelText: "Product Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Product Name!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descontroller..text = product['description'],
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Product Description!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hargaController..text = product['harga'],
                decoration: InputDecoration(labelText: "Harga"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Product Price!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imgController..text = product['image_url'],
                decoration: InputDecoration(labelText: "Image Url"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Image!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      saveProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Berhasil Diubah"),
                        ));
                      });
                    }
                  },
                  child: Text("Update")),
            ],
          )),
    );
  }
}
