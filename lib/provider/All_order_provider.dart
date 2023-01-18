import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/Review_cart.dart';

class My_All_order_Provider with ChangeNotifier {
  void addAllMyorder_List({
    String? cartId,
    String? cartName,
    String? cartImage,
    num? cartPrice,
    int? cartQuantity,
    var cartUnit,
    String? firstName,
    String? lastName,
    String? mobileNo,
    String? scoiety,
    String? street,
    String? landmark,
    String? city,
    String? aera,
    String? pincode,
  }) async {
    await FirebaseFirestore.instance.collection("All_Order").doc(cartId).set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        "firstname": firstName,
        "lastname": lastName,
        "mobileNo": mobileNo,
        "scoiety": scoiety,
        "street": street,
        "landmark": landmark,
        "city": city,
        "aera": aera,
        "pincode": pincode,
      },
    );
  }

  List<ReviewCartModel> MyAllOrderList = [];
  void getAllMyOrderData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot MyorderValue =
        await FirebaseFirestore.instance.collection("My_All_Order").get();
    for (var element in MyorderValue.docs) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
          cartId: element.get('cartId'),
          cartImage: element.get("cartImage"),
          cartName: element.get('cartName'),
          cartPrice: element.get('cartPrice'),
          cartQuantity: element.get('cartQuantity'),
          cartunit: element.get('cartUnit'));
      newList.add(reviewCartModel);
    }
    MyAllOrderList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get MyAllorderDataList {
    return MyAllOrderList;
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
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
      },
    );
  }
  //// TotalPrice  ///

  getTotalPrice() {
    double? total = 0;
    for (var element in MyAllOrderList) {
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
    FirebaseFirestore.instance.collection("All_Order").doc(id).delete();
  }
}
