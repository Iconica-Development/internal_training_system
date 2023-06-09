import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rbac_services/flutter_rbac_services.dart';
import 'package:flutter_rbac_services_firebase/flutter_rbac_services_firebase.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web_application/datasource/trainings/training_datasource.dart';
import 'package:web_application/services/training_service.dart';

import '../login_screen.dart';
import '../not_allowed_screen.dart';

class CreateTraining extends StatefulWidget {
  const CreateTraining({super.key});

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
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

      await uploadFiles(); // wait for files to upload
      if (_goalsController.text.isEmpty) {
        _goalsController.text = '';
      }
      await trainingService.createTraining(
          _nameController.text, _descController.text, _items, downloadUrls);

      context.go('/admin');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully.'),
        ),
      );
    }
  }

// Upload files to Cloud Firestore
  Future<void> uploadFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (final file in result.files) {
        Uint8List? fileBytes = file.bytes;
        String fileName = file.name;

        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('uploads/$fileName')
            .putData(fileBytes!);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    }
  }

  //Pick files using FilePicker
  List<FilePickerResult?> files = [];
  Future<void> pickAndAddFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    files.add(result);
  }

  final List<String> _items = [];
  void _addGoal(String value) {
    setState(() {
      _items.add(value);
    });
  }

  Future<bool> getUserPermission(String userId, String roleId) async {
    FirebaseApp firebaseApp = Firebase.app();
    var firebaseDatasource = FirebaseRbacDatasource(firebaseApp: firebaseApp);
    var rbacService = RbacService(firebaseDatasource);
    bool hasPermission = await rbacService.hasRole(userId, roleId);
    return hasPermission;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginExample();
    }

    return FutureBuilder<bool>(
        future: getUserPermission(user.uid, 'Iv7eRd8e49zx5aibgGUd'),
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
                                                'Training aanmaken',
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
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: TextFormField(
                                              controller: _descController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Training omschrijving',
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
                                          TextField(
                                            controller: _goalsController,
                                            decoration: InputDecoration(
                                              hintText: 'Voer een doel in',
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _addGoal(_goalsController.text);
                                              _goalsController.clear();
                                            },
                                            child: Text('Voeg doel toe'),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: _items.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  title: Text(_items[index]),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          FilledButton(
                                            onPressed: pickAndAddFile,
                                            child: const Text(
                                                'Voeg bestanden toe'),
                                          ),
                                          const SizedBox(height: 15),
                                          FilledButton(
                                            onPressed: _submitForm,
                                            child:
                                                const Text('Training aanmaken'),
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
