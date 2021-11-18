import 'package:flutter/material.dart';
import 'package:onlinemart/screen/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _imgController = TextEditingController();

  Future saveProduct() async {
    final response =
        await http.post(Uri.parse("http://127.0.0.1:8000/api/products"), body: {
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
        title: Text("Add Product"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Product Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Product Name!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descontroller,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Product Description!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(labelText: "Harga"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Product Price!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imgController,
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
                      });
                    }
                  },
                  child: Text("Save")),
            ],
          )),
    );
  }
}
