import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/widget/colors.dart';
import 'package:firebase_ui/widget/textfield.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Regex pattern for a valid email address
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]',
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
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 70),
                MyTextField(
                  hintText: "Name",
                  subtext: "Name",
                  textController: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                MyTextField(
                  hintText: "Email",
                  subtext: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textController: _emailController, // Change this line
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                MyTextField(
                  hintText: "Password",
                  subtext: "Password",
                  textController: _passwordController, // Change this line
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!passwordRegex.hasMatch(value)) {
                      return 'Password must be at least 4 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Text("Already have an account?"),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                          'assets/images/round-arrow_right_alt-24px.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                      } else {
                        print('Unsuccessful');
                      }
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        if (userCredential.user != null) {
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userCredential.user!.email)
                              .set({
                            'username': _nameController.text,
                            'lastname': 'Empty..'
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
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
                        'SIGN UP',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
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
