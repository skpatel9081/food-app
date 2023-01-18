import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:food_app/pages/CheckOut/Add_Delivery_Address/Add_Delivery_Adsress.dart';
import 'package:food_app/pages/CheckOut/Delivery%20Detail/singel_delivery_iteam.dart';
import 'package:food_app/pages/CheckOut/payment_summary/Payment_summary.dart';
import 'package:food_app/pages/my_profile/Address_List.dart';
import 'package:food_app/provider/Checkout_Provider.dart';

import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  DeliveryAddressModel? value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getSelectedDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
        backgroundColor: App_Colors.Primary_Color,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: App_Colors.Primary_Color,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddressList(),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getselectrdDeliveryAddressList.isEmpty
              ? Text(
                  "Add new Address",
                  style: TextStyle(color: App_Colors.white),
                )
              : Text(
                  "Payment Summary",
                  style: TextStyle(color: App_Colors.white),
                ),
          onPressed: () {
            deliveryAddressProvider.getselectrdDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddressList(),
                    ),
                  )
                : CoolAlert.show(
                        context: context,
                        type: CoolAlertType.loading,
                        autoCloseDuration: Duration(seconds: 3))
                    .whenComplete(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            payment_summary(deliverAddressList: value!),
                      ),
                    );
                  });
          },
          color: App_Colors.Primary_Color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getselectrdDeliveryAddressList.isEmpty
              ? Center(
                  child: Container(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  ),
                )
              : Column(
                  children: deliveryAddressProvider
                      .getselectrdDeliveryAddressList
                      .map<Widget>((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      ontapoff: false,
                      address:
                          "aera, ${e.aera}, street, ${e.street}, society ${e.scoirty}, pincode ${e.pinCode}",
                      title: "${e.firstName} ${e.lastName}",
                      number: e.mobileNo!,
                      addressType: e.addressType == "AddressTypes.Home"
                          ? "Home"
                          : e.addressType == "AddressTypes.Other"
                              ? "Other"
                              : "Work",
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }
}
