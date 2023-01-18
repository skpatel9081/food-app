import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/Auth/sign_in_page.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/user_model.dart';
import 'package:food_app/pages/Intro/getting_started_screen.dart';
import 'package:food_app/pages/home/drawer.dart';
import 'package:food_app/pages/my_profile/Address_List.dart';
import 'package:food_app/pages/my_profile/My_order.dart';
import 'package:food_app/pages/my_profile/edit_Profile.dart';
import 'package:food_app/pages/my_profile/t&c.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  MyProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    var userData = userProvider.currentUserData;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text("My Profile"),
      ),
      drawer: DrawerPage(
        userProvider: userProvider,
      ),
      backgroundColor: App_Colors.Primary_Color,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: size.height * .140,
                color: App_Colors.Primary_Color,
              ),
              Container(
                height: size.height * .765,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .015, vertical: size.height * .01),
                decoration: BoxDecoration(
                    color: App_Colors.ScafoldeColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .3),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * .01),
                              child: Container(
                                width: size.width * .650,
                                // color: Colors.black,
                                height: size.height * .08,
                                // color: Colors.black,
                                padding:
                                    EdgeInsets.only(left: size.width * .02),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            userData.userName!,
                                            // "Siddharth Savaliya",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: size.height * .01,
                                          ),
                                          Text(userData.userEmail!)
                                          // Text("Siddharth29amba@gmail.com"),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    editProfile(
                                                        Email:
                                                            userData.userEmail!,
                                                        imageurl:
                                                            userData.userImage!,
                                                        username:
                                                            userData.userName!),
                                              ));
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              App_Colors.Primary_Color,
                                          child: CircleAvatar(
                                            radius: 12,
                                            child: Icon(
                                              Icons.edit,
                                              color: App_Colors.Primary_Color,
                                            ),
                                            backgroundColor:
                                                App_Colors.ScafoldeColor,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyOrder()),
                          );
                        },
                        child: const listTile(
                            icon: Icons.shop_outlined, title: "My Orders"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AddressList()),
                          );
                        },
                        child: const listTile(
                            icon: Icons.location_on_outlined,
                            title: "My Delivery Address"),
                      ),
                      // const listTile(
                      //     icon: Icons.person_outline, title: "Refer A Friends"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => terms(),
                              ));
                        },
                        child: const listTile(
                            icon: Icons.file_copy_outlined,
                            title: "Terms & Conditions"),
                      ),
                      // const listTile(
                      //     icon: Icons.policy_outlined, title: "Privacy Policy"),
                      // const listTile(icon: Icons.add_chart, title: "About"),
                      InkWell(
                        onTap: () {
                          Widget cancelButton = TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          Widget continueButton = TextButton(
                            child: Text("Yes"),
                            onPressed: () async {
                              await storage.delete(key: "uid");
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GettingStartedScreen()),
                              );
                            },
                          );

                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Log Out"),
                            content: Text("Are You Sure to Logout?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: listTile(
                            icon: Icons.exit_to_app_outlined, title: "Log Out"),
                      ),
                    ]),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * .0720, left: size.width * .06),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: App_Colors.Primary_Color,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: App_Colors.ScafoldeColor,
                backgroundImage: NetworkImage(
                  userData.userImage ??
                      "https://firebasestorage.googleapis.com/v0/b/foodapp-1234.appspot.com/o/EXTRA%2FUSER.png?alt=media&token=71a8b177-f884-4af3-9cb3-14a109f7542c",
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class listTile extends StatelessWidget {
  const listTile({Key? key, required this.icon, required this.title})
      : super(key: key);
  final IconData icon;
  final String title;
  // final num ontap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .005),
          child: ListTile(
            leading: Icon(icon),
            title: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        )
      ],
    );
  }
}
