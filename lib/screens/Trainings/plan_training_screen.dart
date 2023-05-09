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

class PlanTraining extends StatefulWidget {
  const PlanTraining({super.key});

  @override
  State<PlanTraining> createState() => _PlanTrainingState();
}

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _PlanTrainingState extends State<PlanTraining> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final TextEditingController _goalsController = TextEditingController();
  List<String> downloadUrls = [];
  DateTime startDate = DateTime(2023, 10, 10);
  DateTime endDate = DateTime(2023, 10, 10);

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var trainingService = TrainingService(
        TrainingDatasource(firebaseApp: Firebase.app()),
      );

      print('Downlaod URLS: $downloadUrls');
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
                                        'Training plannen',
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
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(
                                      'Training kiezen',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          textStyle: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: startDate,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );

                                        if (newDate == null) return;

                                        setState(() {
                                          startDate = newDate;
                                        });
                                      },
                                      child: Text('Selecteer start datum')),
                                  Text(
                                      'Start datum: ${startDate.day}-${startDate.month}-${startDate.year}'),
                                  ElevatedButton(
                                      onPressed: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: endDate,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );

                                        if (newDate == null) return;

                                        setState(() {
                                          startDate = newDate;
                                        });
                                      },
                                      child: Text('Selecteer eind datum')),
                                  Text(
                                      'Eind datum: ${endDate.day}-${endDate.month}-${endDate.year}'),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(_items[index]),
                                        );
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
