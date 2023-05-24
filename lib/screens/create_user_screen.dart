import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rbac_services/flutter_rbac_services.dart';
import 'package:flutter_rbac_services_firebase/flutter_rbac_services_firebase.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:web_application/datasource/user_datasource.dart';
import 'package:web_application/services/user_service.dart';

import 'login_screen.dart';
import 'not_allowed_screen.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitForm() async {
    //Get input values
    final String userFirstname = _firstNameController.text;
    final String userLastname = _lastNameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    //Create Firebase Auth user
    FirebaseRegister(userFirstname, userLastname, email, password);
  }

  Future<bool> getUserPermission(String userId, String roleId) async {
    FirebaseApp firebaseApp = Firebase.app();
    var firebaseDatasource = FirebaseRbacDatasource(firebaseApp: firebaseApp);
    var rbacService = RbacService(firebaseDatasource);
    print('CURRENT USER ID: ' + userId);
    bool hasPermission = await rbacService.hasRole(userId, roleId);
    return hasPermission;
  }

  Future<String?> FirebaseRegister(String userFirstname, String userLastname,
      String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
      String userId = credential.user!.uid;
      UserService userService =
          UserService(UserDatasource(firebaseApp: Firebase.app()));
      userService.createUser(
          userId, userFirstname, userLastname, email, password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('De nieuwe gebruiker is aangemaakt.'),
        ),
      );
      context.go('/admin');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dit wachtwoord is te zwak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Er bestaat al een account met deze email.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginExample();
    }

    return FutureBuilder<bool>(
        future: getUserPermission(user.uid, 'Iv7eRUhqS9zx5aibgGUd'),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            bool isAllowed = snapshot.data ?? false;
            if (!isAllowed) {
              return NotAllowedScreen();
            }
            return Scaffold(
              body: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 556,
                    color: Color(0xFF71C6D1),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 624,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.grey,
                          ),
                          margin: const EdgeInsets.all(116),
                          child: Center(
                            child: SizedBox(
                                height: 600,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                'Gebruiker aanmaken',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 25,
                                                    textStyle: const TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: TextFormField(
                                              controller: _firstNameController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Voornaam',
                                                hintText:
                                                    'Voer een voornaam in',
                                                filled: true,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Voer een voornaam in';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: TextFormField(
                                              controller: _lastNameController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Achternaam',
                                                hintText:
                                                    'Voer een achternaam in',
                                                filled: true,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Voer een achternaam in';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Email',
                                                hintText: 'Voer een email in',
                                                filled: true,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Voer een email in';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: TextFormField(
                                              controller: _passwordController,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Wachtwoord',
                                                hintText:
                                                    'Voer een wachtwoord in',
                                                filled: true,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Voer een wachtwoord in';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          FilledButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _submitForm();
                                              }
                                            },
                                            child: const Text(
                                                'Gebruiker aanmaken'),
                                          ),
                                        ]),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
