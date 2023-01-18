import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Delivery_Address_model.dart';
import 'package:food_app/pages/CheckOut/Add_Delivery_Address/Add_Delivery_Adsress.dart';
import 'package:food_app/pages/CheckOut/Delivery%20Detail/singel_delivery_iteam.dart';
import 'package:food_app/pages/my_profile/t&c.dart';
import 'package:food_app/provider/Checkout_Provider.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  AddressList({Key? key}) : super(key: key);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  @override
  void initState() {
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.getAllDeliveryAddressData();
    super.initState();
  }

  getdata() {
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.getAllDeliveryAddressData();
  }

  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    DeliveryAddressModel? value;
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.AlldeliveryAdressList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text(
          "Your Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: App_Colors.Primary_Color,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Add_Delivery_Address(),
            ),
          );
        },
      ),
      body: deliveryAddressProvider.AlldeliveryAdressList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "                Please Enter Address\n(After add address please refresh page!!!)",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      getdata();
                    },
                    child: Text("refresh"))
              ],
            )
          : AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: deliveryAddressProvider.AlldeliveryAdressList.length,
                itemBuilder: (BuildContext context, int index) {
                  DeliveryAddressModel data =
                      deliveryAddressProvider.AlldeliveryAdressList[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: FadeInAnimation(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 2500),
                          child: SingleDeliveryItem(
                            ontapoff: true,
                            aera: data.aera!,
                            alternateMobileNo: data.alternateMobileNo!,
                            city: data.city!,
                            firstName: data.firstName!,
                            landmark: data.landMark!,
                            lastName: data.lastName!,
                            mobileNo: data.mobileNo!,
                            pincode: data.pinCode!,
                            scoiety: data.scoirty!,
                            street: data.street!,
                            address:
                                "aera, ${data.aera}, street, ${data.street}, society ${data.scoirty}, pincode ${data.pinCode}",
                            title: "${data.firstName} ${data.lastName}",
                            number: data.mobileNo!,
                            addressType: data.addressType == "AddressTypes.Home"
                                ? "Home"
                                : data.addressType == "AddressTypes.Other"
                                    ? "Other"
                                    : "Work",
                          )),
                    ),
                  );
                },
              ),
            ),
    );
  }
}


// ListView.builder(
//         itemCount: deliveryAddressProvider.AlldeliveryAdressList.length,
//         itemBuilder: (context, index) {
          // DeliveryAddressModel data =
          //     deliveryAddressProvider.AlldeliveryAdressList[index];
//           return SingleDeliveryItem(
//             address:
//                 "aera, ${data.aera}, street, ${data.street}, society ${data.scoirty}, pincode ${data.pinCode}",
//             title: "${data.firstName} ${data.lastName}",
//             number: data.mobileNo!,
//             addressType: data.addressType == "AddressTypes.Home"
//                 ? "Home"
//                 : data.addressType == "AddressTypes.Other"
//                     ? "Other"
//                     : "Work",
//           );
//         },
//       ),