import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AuthScreens/login_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    child: Column(
                  children: [
                    Container(
                      height: 55, // Set the desired height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // on press navigate to the ChangePassword page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Return Back',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: SizedBox(
                        height: 40, // Set the desired height of the button,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle the "Sign In" button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFFFF564B), // Set the button color to hex FF564B
                            minimumSize: const Size(double.infinity,
                                0), // Set the button width to 100%
                          ),
                          child: const Text(
                            'SEND OTP CODE',
                            style: TextStyle(
                              color: Colors
                                  .white, // Set the text color to white
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You'll receive a OTP code to reset your password ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ],
    ),
          ),
        );
  }
}

