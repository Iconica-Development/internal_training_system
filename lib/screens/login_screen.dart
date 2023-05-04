import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:web_application/screens/Trainings/trainings_home_screen.dart';

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
        onRegister: (email, password) => print('Register!'),
        // onForgotPassword: (email) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) {
        //         return const ForgotPasswordScreen();
        //       },
        //     ),
        //   );
        // },
      ),
    );
  }
}

Future<void> handleLogin(
  String email,
  String password,
  BuildContext context,
) async {
  //Login is correct
  // var urlPrefix = 'https://a84a-185-10-158-5.ngrok.io';
  // var url = Uri.parse('$urlPrefix/login');
  // var headers = {'Content-type': 'application/json'};
  // var json = '{"username": "$email", "password": "$password"}';
  // var response = await post(url, headers: headers, body: json);

  // if (response.statusCode == 200) {
  //   await _setCustomer(response);

  //   if (context.mounted) {
  //     await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const Trainings(),
  //       ),
  //     );
  //   }
  // } else {
  //   print(response.body);
  //   print(response.statusCode);
  // }
}

// Future<void> _setCustomer(Response response) async {
//   Map<String, dynamic> loginData = jsonDecode(response.body);
//   var customerService = CustomerService();
//   await customerService.setCustomer(loginData['user']);
// }




// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ForgotPasswordForm(
//         options: loginOptions,
//         title: const Text('Forgot password'),
//         description: const Text('Hello world'),
//         onRequestForgotPassword: (email) {
//           print('Forgot password email sent to $email');
//         },
//       ),
//     );
//   }
// }