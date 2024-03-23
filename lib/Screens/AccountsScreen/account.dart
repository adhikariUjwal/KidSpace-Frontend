import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AccountsScreen/add_account.dart';
import 'package:kidspace/Screens/AccountsScreen/update_account.dart';
import 'package:kidspace/Services/accounts.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Widgets/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var accounts = [];
  var fileUrl = Api().fileApi;
  bool isEditing = false;
  bool showEditButton = false;
  bool dataLoaded = false;

  @override
  void initState() {
    getAccountsData();
    super.initState();
  }

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

  getAccountsData() async {
    String? token = await getTokenFromSharedPrefs();
    var res = await UserData().get_user_account(token);
    if (mounted && res != null) {
      setState(() {
        accounts = res;
        dataLoaded = true;
      });
    }
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
                      fit: BoxFit.cover)),
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
                            onPressed: () {},
                            child: const Text(
                              'COMMUNITY',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFFFF564B),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showEditButton = !showEditButton;
                                isEditing = !isEditing;
                              });
                            },
                            child: Text(
                              isEditing ? 'DONE' : 'EDIT',
                              style: const TextStyle(
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
                        child: SizedBox(
                            child: Column(
                          children: [
                            SizedBox(
                              width: 400,
                              child: Container(
                                child: dataLoaded
                                    ? GridView.builder(
                                        itemCount: accounts.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            child: GestureDetector(
                                              onTap: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await prefs.setInt('accountId',
                                                    accounts[index]['id']);
                                                await prefs.setString(
                                                    'accountName',
                                                    accounts[index]['name']);
                                                await prefs.setString(
                                                    'accountImg',
                                                    accounts[index]['image']);
                                                print(
                                                    prefs.getInt('accountId'));
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CustomButtomBar(),
                                                  ),
                                                );
                                              },
                                              child: SizedBox(
                                                width: 160,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Stack(children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: SizedBox(
                                                            height: 150,
                                                            width: 150,
                                                            child:
                                                                CachedNetworkImage(
                                                                  imageUrl: "https://source.unsplash.com/random",
                                                              // imageUrl: fileUrl +
                                                              //     accounts[
                                                              //             index]
                                                              //         ['image'],
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          downloadProgress) =>
                                                                      Center(
                                                                child: CircularProgressIndicator(
                                                                    value: downloadProgress
                                                                        .progress),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )),
                                                      Visibility(
                                                          visible:
                                                              showEditButton,
                                                          child: Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => UpdateAccount(
                                                                            imageUrl: "https://source.unsplash.com/random",
                                                                                // imageUrl: fileUrl + accounts[index]['image'],
                                                                                accountName: accounts[index]['name'],
                                                                                id: accounts[index]['id'],
                                                                              )));
                                                                },
                                                                child: Container(
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border:
                                                                            Border()),
                                                                    child: const Icon(
                                                                        Icons
                                                                            .edit)),
                                                              )))
                                                    ]),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        accounts[index]['name'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 2 / 2.5,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4,
                                        ),
                                      )
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 4,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 1 / 1,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 4,
                                                mainAxisSpacing: 5),
                                        itemBuilder: (context, index) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: 160,
                                              height: 160,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const AddAccount(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 160,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 64,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          'Add New Account', // Replace with the actual account name
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
