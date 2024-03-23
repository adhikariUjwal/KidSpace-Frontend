import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'package:kidspace/Services/accounts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isAdding = false;

  File? _pickedImage;

  TextEditingController accountNameController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<String?> getTokenFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authData = prefs.getString('authData');
    if (authData != null) {
      Map<String, dynamic> jsonData = jsonDecode(authData);
      String? token = jsonData['token'];
      return token;
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isAdding = true;
      });
      String? token = await getTokenFromSharedPrefs();
      String name = accountNameController.text;
      var res = await UserData().addUserAccount(name, _pickedImage, token);
      if (res == true) {
        setState(() {
          isAdding = false;
        });
        _navigate();
      } else {
        Fluttertoast.showToast(
          msg: "Please select low file size!!",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  _navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Account()),
    );
    Fluttertoast.showToast(
      msg: "Successfully added",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  void dispose() {
    accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background/Login page.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Account()));
                              },
                              child: const Text(
                                'BACK',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFFF564B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: GestureDetector(
                                        onTap: _pickImage,
                                        child: Column(
                                          children: [
                                            Form(
                                              child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(0)),
                                                  ),
                                                  child: _pickedImage != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Image.file(
                                                            _pickedImage!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          5)),
                                                              border:
                                                                  Border.all()),
                                                          child: const Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(Icons
                                                                    .image),
                                                                Text(
                                                                    "Add Image"),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                            ),
                                            const SizedBox(height: 20),
                                            TextFormField(
                                              controller: accountNameController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                fillColor: Colors.white,
                                                hintText: 'Account Name',
                                                contentPadding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: 10,
                                                    horizontal:
                                                        12), // Adjust the padding values as desired
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: _submitForm,                                                
                                              child: const Text("Submit"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
