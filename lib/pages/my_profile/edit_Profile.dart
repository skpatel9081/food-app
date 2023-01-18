import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class editProfile extends StatefulWidget {
  const editProfile(
      {Key? key,
      required this.imageurl,
      required this.username,
      required this.Email})
      : super(key: key);
  final String imageurl;
  final String username;
  final String Email;
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formkey = GlobalKey<FormState>();
  final nameEditController = TextEditingController();
  final emailEditController = TextEditingController();
  String? url;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<UploadTask> uploadedTasks = [];
  ProductProvider? productProvider;
  List<File> selectedFiles = [];

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage
        .ref()
        .child("images/${DateTime.now().toString()}")
        .putFile(file);
    return task;
  }

  saveImageUrlToFirebase(UploadTask task) {
    task.snapshotEvents.listen((snapShot) {
      if (snapShot.state == TaskState.success) {
        snapShot.ref.getDownloadURL().then((imageUrl) {
          snapShot.ref.getDownloadURL().then((imageUrl) {
            url = imageUrl;
          });
        });
      }
    });
  }

  Future selectFileToUpload() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        selectedFiles.clear();

        result.files.forEach((selectedFile) {
          File file = File(selectedFile.path!);
          selectedFiles.add(file);
        });

        selectedFiles.forEach((file) {
          final UploadTask task = uploadFileToStorage(file);
          saveImageUrlToFirebase(task);

          setState(() {
            uploadedTasks.add(task);
          });
        });
      } else {
        print("User has cancelled the selection");
      }
    } catch (e) {
      print(e);
    }
  }

  var name = "";
  var email = "";
  @override
  Widget build(BuildContext context) {
    var name = widget.username;
    var email = widget.Email;
    UserProvider userProvider = Provider.of(context);
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: App_Colors.ScafoldeColor,
        appBar: AppBar(
            shadowColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: const Text(
              "My Profile",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: App_Colors.Primary_Color),
        // drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.410,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            widget.username,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.140,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.65,
                    ),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                        color: App_Colors.black,
                      ),
                      controller: nameEditController,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: App_Colors.white,
                        border: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintMaxLines: 1,
                        hintText: widget.username,
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 15),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: App_Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.045,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.66,
                    ),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                        color: App_Colors.black,
                      ),
                      controller: emailEditController,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!value.contains(
                          '@,gmail.com',
                        )) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: App_Colors.white,
                        border: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintMaxLines: 1,
                        hintText: widget.Email,
                        errorStyle: const TextStyle(
                            color: Colors.redAccent, fontSize: 15),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: App_Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.115,
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseAuth userCredential = await FirebaseAuth.instance;
                      userProvider.updateUserdata(
                          userName: nameEditController.text,
                          userEmail: emailEditController.text,
                          currentUser: userCredential.currentUser,
                          userImage: url ?? widget.imageurl);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.055,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: App_Colors.Primary_Color,
                        // border: Border.all(color: Colors.black, width: 1),

                        borderRadius: BorderRadius.circular(100),

                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Update Profile",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.width * 0.05,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(url ?? widget.imageurl),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.150,
                left: MediaQuery.of(context).size.width * 0.29,
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey[300],
                      child: InkWell(
                        onTap: () async {
                          selectFileToUpload();
                        },
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
