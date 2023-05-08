import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';

final loginOptions = LoginOptions(
  emailDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  passwordDecoration: const InputDecoration(
    prefixIcon: Icon(Icons.password),
    border: OutlineInputBorder(),
  ),
  title: const Text('Iconica Internal Training System'),
  image: const FlutterLogo(
    size: 200,
  ),
  requestForgotPasswordButtonBuilder: (
    context,
    onPressed,
    isDisabled,
    onDisabledPress,
    translations,
  ) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: isDisabled ? onDisabledPress : onPressed,
        child: const Text('Send request'),
      ),
    );
  },
);

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailPasswordLoginForm(
        options: loginOptions,
        onLogin: (email, password) async =>
            handleLogin(email, password, context),
      ),
    );
  }
}

Future<void> checkUserState() async {
  print('TEST');
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

Future<UserCredential?> handleLogin(
    String email, String password, BuildContext context) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('CORRECT.');
    checkUserState();
    context.go('/admin');

    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Er betsaat geen gebruiker met deze email.'),
        ),
      );
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Het wachtwoord voor deze gebruiker is incorrect.'),
        ),
      );
    }
  }
}

// Future<void> _setCustomer(Response response) async {
//   Map<String, dynamic> loginData = jsonDecode(response.body);
//   var customerService = CustomerService();
//   await customerService.setCustomer(loginData['user']);
// }