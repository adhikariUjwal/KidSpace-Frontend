import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'package:kidspace/Screens/Subscription_screen/subscription_screen.dart';
import 'package:kidspace/Services/google_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthButton extends StatefulWidget {
  const GoogleAuthButton({super.key});

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  final authController = AuthController();
  bool isSigning = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  _loginToLaravel(token) async {
    var response = await authController.loginWithGooogle(token);
    if (response == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authData = jsonDecode(prefs.getString('authData') ?? '{}');
      if (authData['isSubscribe'] == 'true') {
        _navigateToAccount();
      } else {
        _navigateToSubscriptionScreen();
      }
    } else {
      _showSnackBar();
      setState(() {
        isSigning = false;
      });
    }
  }

  _navigateToAccount() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Account()));
  }

  _navigateToSubscriptionScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SubscriptionPage()));
  }

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Error: Cannot login',
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      backgroundColor: Colors.red,
    ));
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        setState(() {
          isSigning = true;
        });
        account.authentication
            .then((value) => {_loginToLaravel(value.accessToken)});
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isSigning = true;
        });
        try {
          await _googleSignIn.signIn();
        } catch (_) {
          _showSnackBar();
        }
      },
      child: Container(
        height: 34,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/google.webp', width: 20, height: 20),
            const SizedBox(width: 10),
            const Text('Sign in with Google'),
          ],
        ),
      ),
    );
  }
}
