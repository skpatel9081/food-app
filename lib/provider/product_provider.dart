import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;
  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
        productImage: element.get("ProductImage"),
        productName: element.get("ProductName"),
        productPrice: element.get("ProductPrice"),
        productId: element.get("ProductId"),
        productUnit: element.get("ProductUnit"),
        productDescription: element.get("ProductDescription"),
        productQuantity: 1);
    search.add(productModel!);
    // search.add(productModel);
  }

  ////////////////////////////////////////////HerbCollection////////////////////////////////
  List<ProductModel> herbsProductList = [];
  fatchHerbsProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("HerbsProduct")
        .get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

////////////////////////////////////////////FreshCollection////////////////////////////////
  List<ProductModel> FreshProductList = [];

  fatchFreshProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("FreshProduct")
        .get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    FreshProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return FreshProductList;
  }

  ////////////////////////////////////////////RootCollection////////////////////////////////
  List<ProductModel> RootProductList = [];

  fatchRootProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("RootProduct")
        .get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    RootProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return RootProductList;
  }

////////////////////////////////////////////Search////////////////////////////////
  List<ProductModel> get getAllroductDataList {
    return search;
  }

  ////////////////////////////////////////////Spices////////////////////////////////
  List<ProductModel> spicesProductList = [];
  fatchSpicesProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("AllProductCategories")
        .doc("Categories")
        .collection("Spices")
        .get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    spicesProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getSpicesProductDataList {
    return spicesProductList;
  }
}
