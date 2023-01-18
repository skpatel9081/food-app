import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireData extends StatefulWidget {
  const FireData({Key? key}) : super(key: key);

  @override
  State<FireData> createState() => _FireDataState();
}

class _FireDataState extends State<FireData> {
  final _formkey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final ProductNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final ProductImageController = TextEditingController();
  // ignore: non_constant_identifier_names
  final ProductPriceController = TextEditingController();
  void cleartext() {
    ProductNameController.clear();
    ProductImageController.clear();
    ProductPriceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            FirebaseFirestore.instance.collection('HerbsProduct').add(
              {
                "ProductName": ProductNameController.text,
                "ProductImage": ProductImageController.text,
                "ProductPrice": ProductPriceController.text,
              },
            );
          }
        },
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
                controller: ProductNameController,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    fillColor: Colors.transparent,
                    filled: true,
                    hintText: "Enter Product Name",
                    label: const Text("Name"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                controller: ProductImageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Product Image Url';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    fillColor: Colors.transparent,
                    filled: true,
                    hintText: "Enter Product Url",
                    label: const Text("Url"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                controller: ProductPriceController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Product Price';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    fillColor: Colors.transparent,
                    filled: true,
                    hintText: "Enter Price",
                    label: const Text("Price"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
