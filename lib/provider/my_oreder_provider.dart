import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/Review_cart.dart';

class Myorder_Provider with ChangeNotifier {
  void addMyorder_List({
    String? cartId,
    String? cartName,
    String? cartImage,
    num? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    await FirebaseFirestore.instance
        .collection("My_Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourOrderd")
        .doc(cartId)
        .set(
      {
        "OederId": cartId,
        "OederName": cartName,
        "OederImage": cartImage,
        "OederPrice": cartPrice,
        "OederQuantity": cartQuantity,
        "OederUnit": cartUnit,
      },
    );
  }

  List<ReviewCartModel> MyOrderList = [];
  void getMyOrderData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot MyorderValue = await FirebaseFirestore.instance
        .collection("My_Order")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourOrderd")
        .get();
    for (var element in MyorderValue.docs) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
          cartId: element.get('OederId'),
          cartImage: element.get("OederImage"),
          cartName: element.get('OederName'),
          cartPrice: element.get('OederPrice'),
          cartQuantity: element.get('OederQuantity'),
          cartunit: element.get('OederUnit'));
      newList.add(reviewCartModel);
    }
    MyOrderList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get MyorderDataList {
    return MyOrderList;
  }

//update//
  void updateMyOrderData({
    String? cartId,
    String? cartName,
    String? cartImage,
    int? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviwCart")
        .doc(cartId)
        .update(
      {
        "OederId": cartId,
        "OederName": cartName,
        "OederImage": cartImage,
        "OederPrice": cartPrice,
        "OederQuantity": cartQuantity,
      },
    );
  }
  //// TotalPrice  ///

  getTotalPrice() {
    double? total = 0;
    for (var element in MyOrderList) {
      // total += element.cartPrice*element.cartQuantity;
      total = total! + element.cartPrice! * element.cartQuantity!;
      print(total);
    }
    return total;
  }

  //////////////////////ReviewCartDelete//////////////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviwCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  deleteOrder(id) {
    FirebaseFirestore.instance
        .collection("My_Order")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourOrderd")
        .doc(id)
        .delete();
  }
}
