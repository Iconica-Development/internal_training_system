import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

class NotAllowedScreen extends StatefulWidget {
  const NotAllowedScreen({super.key});

  @override
  State<NotAllowedScreen> createState() => _NotAllowedScreenState();
}

class _NotAllowedScreenState extends State<NotAllowedScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginExample();
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        'Je hebt geen toegang tot deze data.',
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25,
                                            textStyle: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  FilledButton(
                                    onPressed: () => context.go('/login'),
                                    child: const Text('Log opnieuw in'),
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
}
