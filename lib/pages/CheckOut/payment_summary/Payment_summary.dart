import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:food_app/pages/CheckOut/Delivery%20Detail/singel_delivery_iteam.dart';

import 'package:food_app/pages/CheckOut/payment_summary/my_google_pay.dart';
import 'package:food_app/pages/CheckOut/payment_summary/order_iteam.dart';
import 'package:food_app/pages/invoice/Api/pdf_Api.dart';
import 'package:food_app/pages/invoice/Api/pdf_invoice_api.dart';
import 'package:food_app/pages/invoice/model/customer.dart';
import 'package:food_app/pages/invoice/model/invoice.dart';
import 'package:food_app/pages/invoice/model/supplier.dart';
import 'package:food_app/pages/my_profile/My_order.dart';
import 'package:food_app/provider/All_order_provider.dart';
import 'package:food_app/provider/my_oreder_provider.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:provider/provider.dart';

import 'package:notification_permissions/notification_permissions.dart';

class payment_summary extends StatefulWidget {
  payment_summary({Key? key, required this.deliverAddressList})
      : super(key: key);
  final DeliveryAddressModel deliverAddressList;
  @override
  State<payment_summary> createState() => _payment_summaryState();
}

enum AddressTypes {
  COD,
  Onlinepayment,
}

class _payment_summaryState extends State<payment_summary> {
  var myType = AddressTypes.Onlinepayment;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final List<InvoiceItem> invoice1 = [];
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Myorder_Provider myorder_provider = Provider.of(context);
    My_All_order_Provider my_all_order_provider = Provider.of(context);
    ReviewCartProvider reviewCartProvider = Provider.of(context);

    reviewCartProvider.getReviewCartData();
    Size size = MediaQuery.of(context).size;
    num totalPrice = reviewCartProvider.getTotalPrice();
    num discount = 0;
    num? discountValue = 0;
    num shippingChanrge = totalPrice * .05;

    num? total;
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue + shippingChanrge;
    } else {
      total = totalPrice;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "₹${total}",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        // ignore: sized_box_for_whitespace
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () async {
              final date = DateTime.now();
              final dueDate = date.add(Duration(days: 7));

              final invoice = Invoice(
                  supplier: Supplier(
                    name: 'Daily Food City',
                    address: 'The Palladium 3024,Yogichowk,surat',
                    paymentInfo: 'https://paypal.me/sarahfieldzz',
                  ),
                  customer: Customer(
                    name:
                        "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                    address:
                        "${widget.deliverAddressList.street},${widget.deliverAddressList.scoirty},\n${widget.deliverAddressList.aera},${widget.deliverAddressList.city},pinCode-${widget.deliverAddressList.pinCode}",
                  ),
                  info: InvoiceInfo(
                    date: date,
                    dueDate: dueDate,
                    description: 'My description...',
                    number: '${DateTime.now().year}-0001',
                  ),
                  items: reviewCartProvider.reviewCartDataList.map((e) {
                    return InvoiceItem(
                        description: e.cartName!,
                        date: DateTime.now(),
                        quantity: e.cartQuantity!,
                        vat: 0.05,
                        unitPrice: e.cartPrice!);
                  }).toList());

              final pdfFile = await PdfInvoiceApi.generate(invoice);

              PdfApi.openFile(pdfFile);
              reviewCartProvider.getReviewCartDataList.map((e) {
                return myorder_provider.addMyorder_List(
                  cartId: e.cartId,
                  cartImage: e.cartImage,
                  cartName: e.cartName,
                  cartPrice: e.cartPrice,
                  cartQuantity: e.cartQuantity,
                  cartUnit: e.cartunit,
                );
              }).toList();

              reviewCartProvider.getReviewCartDataList.map((e) {
                return my_all_order_provider.addAllMyorder_List(
                    cartId: e.cartId,
                    cartImage: e.cartImage,
                    cartName: e.cartName,
                    cartPrice: e.cartPrice,
                    cartQuantity: e.cartQuantity,
                    cartUnit: e.cartunit,
                    aera: widget.deliverAddressList.aera,
                    city: widget.deliverAddressList.city,
                    firstName: widget.deliverAddressList.firstName,
                    landmark: widget.deliverAddressList.landMark,
                    lastName: widget.deliverAddressList.lastName,
                    mobileNo: widget.deliverAddressList.mobileNo,
                    pincode: widget.deliverAddressList.pinCode,
                    scoiety: widget.deliverAddressList.scoirty,
                    street: widget.deliverAddressList.street);
              }).toList();
              CoolAlert.show(
                context: context,
                onConfirmBtnTap: () {
                  myType == AddressTypes.Onlinepayment
                      ? Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyOrder()),
                        )
                      : Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyOrder()),
                        );
                },
                type: CoolAlertType.success,
                text: 'Order completed successfully!',
              );
              reviewCartProvider.deletedata();
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                color: App_Colors.white,
              ),
            ),
            color: App_Colors.Primary_Color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: size.height * .01),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SingleDeliveryItem(
                      ontapoff: false,
                      address:
                          "aera, ${widget.deliverAddressList.aera}, street, ${widget.deliverAddressList.street}, society ${widget.deliverAddressList.scoirty}, pincode ${widget.deliverAddressList.pinCode}",
                      title:
                          "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                      number: widget.deliverAddressList.mobileNo!,
                      addressType: widget.deliverAddressList.addressType ==
                              "AddressTypes.Home"
                          ? "Home"
                          : widget.deliverAddressList.addressType ==
                                  "AddressTypes.Other"
                              ? "Other"
                              : "Work",
                    ),
                    Divider(),
                    ExpansionTile(
                      children:
                          reviewCartProvider.getReviewCartDataList.map((e) {
                        return OrderItem(
                          e: e,
                        );
                      }).toList(),
                      title: Text(
                          "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                    ),
                    Divider(),
                    ListTile(
                      minVerticalPadding: size.height * .01,
                      leading: const Text(
                        "Sub Total",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        "₹${totalPrice}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      minVerticalPadding: size.height * .01,
                      leading: Text(
                        "GST Charge",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        "₹$shippingChanrge",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // ListTile(
                    //   minVerticalPadding: size.height * .01,
                    //   leading: Text(
                    //     "Compen Discount",
                    //     style: TextStyle(
                    //         // fontWeight: FontWeight.bold,
                    //         color: Colors.grey[600]),
                    //   ),
                    //   trailing: Text(
                    //     "₹$discountValue",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Divider(),
                    ListTile(
                      leading: Text("Payment Option"),
                    ),
                    RadioListTile(
                      value: AddressTypes.COD,
                      groupValue: myType,
                      title: Text("COD(Cash On Dilivery)"),
                      onChanged: (AddressTypes? value) {
                        setState(() {
                          myType = value!;
                        });
                      },
                      secondary: Icon(
                        Icons.home,
                        color: App_Colors.Primary_Color,
                      ),
                    ),
                    // RadioListTile(
                    //   value: AddressTypes.Onlinepayment,
                    //   groupValue: myType,
                    //   title: Text("Online Payment"),
                    //   onChanged: (AddressTypes? value) {
                    //     setState(() {
                    //       myType = value!;
                    //     });
                    //   },
                    //   secondary: Icon(
                    //     Icons.payment_rounded,
                    //     color: App_Colors.Primary_Color,
                    //   ),
                    // ),
                  ],
                );
              })),
    );
  }
}
