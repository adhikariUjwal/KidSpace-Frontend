import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'package:kidspace/Services/google_login_service.dart';

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
    print("Login to laravel response is: $response");
    if (response == true) {
      _navigate();
      setState(() {
        isSigning = false;
      });
    } else {
      _showSnackBar();
      setState(() {
        isSigning = false;
      });
    }
  }

  _navigate() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Account()));
  }

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Error: Cannot login',
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 74, 64, 255),
    ));
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print("The account is:$account");
      if (account != null) {
        setState(() {
          isSigning = true;
        });
        account.authentication.then((value) => {
              _loginToLaravel({'access_token': value.accessToken})
            });
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
          var res = await _googleSignIn.signIn();
          print("The response after _googleSignIn.signIn is: $res");
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
