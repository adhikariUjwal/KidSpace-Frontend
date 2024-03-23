import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'package:kidspace/Services/accounts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAccount extends StatefulWidget {
  final String imageUrl;
  final String accountName;
  final int id;
  const UpdateAccount({
    super.key,
    required this.imageUrl,
    required this.accountName,
    required this.id,
  });

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Get User Token
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
      String? token = await getTokenFromSharedPrefs();
      String name = accountName_controller.text;
      String prevImage = widget.imageUrl;
      int userId = widget.id;
      UserData().update_user_account(
          context, name, _pickedImage, token, userId, prevImage);
    }
  }

  TextEditingController accountName_controller = TextEditingController();
  @override
  void initState() {
    accountName_controller.text = widget.accountName;
    super.initState();
  }

  @override
  void dispose() {
    accountName_controller.dispose();
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
                      
                        const SizedBox(height: 25),
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
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.network(
                                                                    widget
                                                                        .imageUrl),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                            ),
                                            const SizedBox(height: 20),
                                            TextFormField(
                                              controller:
                                                  accountName_controller,
                                              decoration: InputDecoration(
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                fillColor: Colors.white,
                                                hintText: 'Name',
                                                contentPadding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: 10,
                                                    horizontal:
                                                        12), // Adjust the padding values as desired
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.yellow)),
                                                  onPressed: () {
                                                    const SnackBar(
                                                        content: Text(
                                                            "Updating user..."));
                                                    _submitForm();
                                                  },
                                                  child: const Text(
                                                    'Update User',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.red)),
                                                    onPressed: () {
                                                      int userId = widget.id;
                                                      UserData()
                                                          .delete_user_account(
                                                              context, userId);
                                                    },
                                                    child: const Text(
                                                      'Delete User',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
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
