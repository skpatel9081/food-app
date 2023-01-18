import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/my_profile/Address_List.dart';
import 'package:food_app/provider/Checkout_Provider.dart';
import 'package:provider/provider.dart';

class SingleDeliveryItem extends StatefulWidget {
  final String title;
  final String address;
  final String number;
  final String addressType;
  final String? firstName;
  final String? lastName;
  final String? mobileNo;
  final String? alternateMobileNo;
  final String? scoiety;
  final String? street;
  final String? landmark;
  final String? city;
  final String? aera;
  final String? pincode;
  final bool ontapoff;
  SingleDeliveryItem({
    required this.title,
    required this.addressType,
    required this.address,
    required this.number,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.alternateMobileNo,
    this.scoiety,
    this.street,
    this.landmark,
    this.city,
    this.aera,
    this.pincode,
    required this.ontapoff,
  });

  @override
  State<SingleDeliveryItem> createState() => _SingleDeliveryItemState();
}

class _SingleDeliveryItemState extends State<SingleDeliveryItem> {
  bool ontab = false;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        if (widget.ontapoff == true) {
          setState(() {
            ontab = !ontab;
          });
          if (ontab == true) {
            checkoutProvider.firstName = widget.firstName;
            checkoutProvider.lastName = widget.lastName;
            checkoutProvider.mobileNo = widget.mobileNo;
            checkoutProvider.alternateMobileNo = widget.alternateMobileNo;
            checkoutProvider.scoiety = widget.scoiety;
            checkoutProvider.street = widget.street;
            checkoutProvider.landmark = widget.landmark;
            checkoutProvider.city = widget.city;
            checkoutProvider.aera = widget.aera;
            checkoutProvider.pincode = widget.pincode;
            checkoutProvider.setaddress(widget.addressType);
          }
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressList(),
              ));
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                  Container(
                    width: 60,
                    padding: EdgeInsets.all(1),
                    height: 20,
                    decoration: BoxDecoration(
                        color: App_Colors.Primary_Color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        widget.addressType,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              leading: CircleAvatar(
                radius: 8,
                backgroundColor: ontab == true ? Colors.red : Colors.black,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.address),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.number),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
