import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AuthScreens/forgot_password_screen.dart';
import 'package:kidspace/Screens/AuthScreens/register_screen.dart';
import 'package:kidspace/Services/auth.dart';
import 'package:kidspace/Widgets/google_login_button.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/Login page.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 150, left: 20, right: 20),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

// Login Form
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  void submitForm() {
    if (_formKey.currentState!.validate()) {
      String userEmail = userEmailController.text;
      String userPassword = passwordController.text;
      AuthService().login(context, userEmail, userPassword);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      child: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 45,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      backgroundColor: const Color.fromRGBO(255, 86, 75, 1),
                    ),
                    child: const Text(
                      "Go",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Don't have an account? "),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Create one',
                  style: TextStyle(color: Color.fromRGBO(255, 86, 75, 1)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text('Or'),
          const SizedBox(height: 20),
          const GoogleAuthButton(),
        ],
      ),
    );
  }
}
