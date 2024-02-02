import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/widget/colors.dart';
import 'package:firebase_ui/widget/textfield.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //String email = "", pass = "";
  bool _obscureText = true;

  // Regex pattern for a valid email address
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z]+@[a-zA-Z]+.[a-z]',
  );

  // Regex pattern for a valid password (at least 4)
  static final RegExp passwordRegex = RegExp(
    r'^.{6,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80 ),
                const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100),
                MyTextField(
                  hintText: "Email",
                  subtext: "Email",
                  textController: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                MyTextField(
                  hintText: "Password",
                  subtext: "Password",
                  textController: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!passwordRegex.hasMatch(value)) {
                      return 'Password must be at least 4 characters long';
                    }
                    // You can add more complex password validation if needed
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot your password?"),
                      SizedBox(width: 5),
                      Image.asset(
                          'assets/images/round-arrow_right_alt-24px.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text.trim(), password: _passwordController.text.trim())
                          .then((value) {
                        if (_formKey.currentState!.validate()) {
                          print("Successfull");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()),
                          );
                        } else {
                          print('Unsuccessful');
                        }
                      });
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primaryColor, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Circular border radius
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 140),
                Container(
                  child: Column(
                    children: [
                      Text("Or Login with social account"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/Facebook.png'),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/Google.png'),
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
      ),
    );
  }
}
