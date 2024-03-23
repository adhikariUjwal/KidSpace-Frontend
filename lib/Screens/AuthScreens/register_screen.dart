import 'package:flutter/material.dart';
import 'package:kidspace/Screens/AuthScreens/login_screen.dart';
import 'package:kidspace/Services/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

// Login Form
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      String fullName = fullNameController.text;
      String userEmail = userEmailController.text;
      String userPassword = passwordController.text;
      AuthService().registerUserInfo(context, fullName, userEmail, userPassword, userPassword);
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
                  controller: fullNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Full Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Full Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Confirm Password',
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
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                
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
                padding: EdgeInsets.only(left: 50),
                child: Text("Already have an account? "),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Color.fromRGBO(255, 86, 75, 1)),
                ),
              ),
            ],
          ),
       
        ],
      ),
    );
  }
}
