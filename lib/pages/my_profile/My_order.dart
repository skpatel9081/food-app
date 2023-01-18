import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Review_cart.dart';
import 'package:food_app/pages/home/bottam_bar.dart';
import 'package:food_app/provider/All_order_provider.dart';
import 'package:food_app/provider/my_oreder_provider.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  @override
  void initState() {
    Myorder_Provider myorder_provider = Provider.of(context, listen: false);
    myorder_provider.getMyOrderData();
    super.initState();
  }

  Widget build(BuildContext context) {
    Myorder_Provider myorder_provider = Provider.of(context);
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home2(),
              ));
        },
        child: Icon(Icons.home),
      ),
      backgroundColor: App_Colors.ScafoldeColor,
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text(
          "Your Order",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: myorder_provider.MyOrderList.length,
          itemBuilder: (BuildContext context, int index) {
            ReviewCartModel data = myorder_provider.MyOrderList[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 2500),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            data.cartImage!,
                            width: 60,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.cartName!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                data.cartunit,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                "₹${data.cartPrice! * data.cartQuantity!}",
                              ),
                            ],
                          ),
                          subtitle: Text("Qty-${data.cartQuantity.toString()}"),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       warningAlert;
                        //     },
                        //     child: Text(
                        //       "Cancel Order",
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     )).
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: MaterialButton(
                                color: Colors.red,
                                minWidth: double.infinity,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.confirm,
                                    text: 'Do you want to cancel order?',
                                    confirmBtnText: 'Yes',
                                    onConfirmBtnTap: () {
                                      My_All_order_Provider
                                          my_all_order_provider =
                                          Provider.of(context, listen: false);
                                      myorder_provider.deleteOrder(data.cartId);
                                      my_all_order_provider
                                          .deleteOrder(data.cartId);
                                      myorder_provider.getMyOrderData();
                                      Navigator.of(context).pop();
                                    },
                                    cancelBtnText: 'No',
                                    confirmBtnColor: Colors.green,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Text(
                                    "Cancel Order",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton(
      {VoidCallback? onTap, required String text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MaterialButton(
        color: color,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
