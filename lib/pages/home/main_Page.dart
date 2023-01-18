import 'package:flutter/material.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/home/drawer.dart';

import 'package:food_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    var userData = userProvider.currentData;
    return Scaffold(
      body: Stack(children: [
        // DrawerPage(),
        Home_Page1(),
      ]),
    );
  }
}
