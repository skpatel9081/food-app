import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? alternateMobileNo;
  String? scoiety;
  String? street;
  String? landmark;
  String? city;
  String? aera;
  String? pincode;
  num name = 1;
  LocationData? setLoaction;
  void validator(context, myType) async {
    if (firstName == null) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName == null) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo == null) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (mobileNo! == 10) {
      Fluttertoast.showToast(msg: "mobileNo not valid");
    } else if (alternateMobileNo == null) {
      Fluttertoast.showToast(msg: "alternateMobileNo is empty");
    } else if (alternateMobileNo! == 10) {
      Fluttertoast.showToast(msg: "mobileNo not valid");
    } else if (scoiety == null) {
      Fluttertoast.showToast(msg: "scoiety is empty");
    } else if (street == null) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark == null) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city == null) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (aera == null) {
      Fluttertoast.showToast(msg: "aera is empty");
    } else if (pincode == null) {
      Fluttertoast.showToast(msg: "pincode is empty");
    } else {
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourAdresses")
          .doc()
          .set({
        "firstname": firstName,
        "lastname": lastName,
        "mobileNo": mobileNo,
        "alternateMobileNo": alternateMobileNo,
        "scoiety": scoiety,
        "street": street,
        "landmark": landmark,
        "city": city,
        "aera": aera,
        "pincode": pincode,
        "addressType": myType.toString(),
        "longitude": setLoaction!.longitude,
        "latitude": setLoaction!.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "selected your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  void setaddress(myType) async {
    print(setLoaction);
    if (firstName == null) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName == null) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo == null) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (alternateMobileNo == null) {
      Fluttertoast.showToast(msg: "alternateMobileNo is empty");
    } else if (scoiety == null) {
      Fluttertoast.showToast(msg: "scoiety is empty");
    } else if (street == null) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark == null) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city == null) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (aera == null) {
      Fluttertoast.showToast(msg: "aera is empty");
    } else if (pincode == null) {
      Fluttertoast.showToast(msg: "pincode is empty");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("DeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourselectedAdresses")
          .doc("selected")
          .set({
        "firstname": firstName,
        "lastname": lastName,
        "mobileNo": mobileNo,
        "alternateMobileNo": alternateMobileNo,
        "scoiety": scoiety,
        "street": street,
        "landmark": landmark,
        "city": city,
        "aera": aera,
        "pincode": pincode,
        "addressType": myType.toString(),
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "deliver address set");

        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    QuerySnapshot db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourAdresses")
        .get();
    if (db.docs.isNotEmpty) {
      db.docs.firstWhere((element) {
        deliveryAddressModel = DeliveryAddressModel(
          firstName: element.get("firstname"),
          lastName: element.get("lastname"),
          addressType: element.get("addressType"),
          aera: element.get("aera"),
          alternateMobileNo: element.get("alternateMobileNo"),
          city: element.get("city"),
          landMark: element.get("landmark"),
          mobileNo: element.get("mobileNo"),
          pinCode: element.get("pincode"),
          scoirty: element.get("scoiety"),
          street: element.get("street"),
        );
        newList.add(deliveryAddressModel);
        return true;
      });

      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

  List<DeliveryAddressModel> deliveryselectedAdressList = [];
  getSelectedDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    QuerySnapshot db = await FirebaseFirestore.instance
        .collection("DeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourselectedAdresses")
        .get();
    if (db.docs.isNotEmpty) {
      db.docs.firstWhere((element) {
        deliveryAddressModel = DeliveryAddressModel(
          firstName: element.get("firstname"),
          lastName: element.get("lastname"),
          addressType: element.get("addressType"),
          aera: element.get("aera"),
          alternateMobileNo: element.get("alternateMobileNo"),
          city: element.get("city"),
          landMark: element.get("landmark"),
          mobileNo: element.get("mobileNo"),
          pinCode: element.get("pincode"),
          scoirty: element.get("scoiety"),
          street: element.get("street"),
        );
        newList.add(deliveryAddressModel);
        return true;
      });

      notifyListeners();
    }

    deliveryselectedAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getselectrdDeliveryAddressList {
    return deliveryselectedAdressList;
  }

  List<DeliveryAddressModel> AlldeliveryAdressList = [];
  getAllDeliveryAddressData() async {
    List<DeliveryAddressModel> newList1 = [];

    DeliveryAddressModel deliveryAddressModel;
    QuerySnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourAdresses")
        .get();

    for (var element in _db.docs) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: element.get("firstname"),
        lastName: element.get("lastname"),
        addressType: element.get("addressType"),
        aera: element.get("aera"),
        alternateMobileNo: element.get("alternateMobileNo"),
        city: element.get("city"),
        landMark: element.get("landmark"),
        mobileNo: element.get("mobileNo"),
        pinCode: element.get("pincode"),
        scoirty: element.get("scoiety"),
        street: element.get("street"),
      );
      newList1.add(deliveryAddressModel);
    }

    AlldeliveryAdressList = newList1;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getAllDeliveryAddressList {
    return AlldeliveryAdressList;
  }
}
