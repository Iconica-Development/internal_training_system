import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signOut().then((value) => print("User logged out"));
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Navigating to Login Screen...'),
    );
  }
}
