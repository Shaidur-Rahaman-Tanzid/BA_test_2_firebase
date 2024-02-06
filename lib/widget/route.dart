import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/log_in.dart';
import 'package:flutter/material.dart';
import '../home_page.dart';
import '../sign_up.dart';

class RouteA extends StatefulWidget {
  const RouteA({Key? key}) : super(key: key);

  @override
  State<RouteA> createState() => _RouteAState();
}

class _RouteAState extends State<RouteA> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LogIn();
        }
      },
    ));
  }
}
