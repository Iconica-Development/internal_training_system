import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web_application/datasource/trainings/training_datasource.dart';
import 'package:web_application/services/training_service.dart';

import '../login_screen.dart';

class TrainingApplication extends StatefulWidget {
  const TrainingApplication({super.key});

  @override
  State<TrainingApplication> createState() => _TrainingApplicationState();
}

class _TrainingApplicationState extends State<TrainingApplication> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();
  List<String> downloadUrls = [];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var trainingService = TrainingService(
        TrainingDatasource(firebaseApp: Firebase.app()),
      );

      context.go('/admin');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully.'),
        ),
      );
    }
  }

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
                                        'Inschrijven op training',
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25,
                                            textStyle: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Training naam',
                                        hintText:
                                            'Voer een naam in voor de training',
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: TextFormField(
                                      controller: _descController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Training omschrijving',
                                        hintText:
                                            'Voer een omschrijving in voor de training',
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a desc';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  FilledButton(
                                    onPressed: _submitForm,
                                    child: const Text('Training aanmaken'),
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
