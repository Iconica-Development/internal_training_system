import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/datasource/trainings/training_datasource.dart';
import 'package:web_application/services/training_service.dart';

class CreateTraining extends StatefulWidget {
  const CreateTraining({super.key});

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _goalsController = TextEditingController();

  void createTraining(String trainingName, String trainingDesc, String trainingGoals) async {

  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Save user's name in Firestore
    var trainingService = TrainingService(
      TrainingDatasource(firebaseApp: Firebase.app()),
    );

    await trainingService.createTraining(_nameController.text, _descController.text, _goalsController.text);

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
                                  TextFormField(
                                    controller: _goalsController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Training goals',
                                      hintText:
                                          'Voer een goal in',
                                      filled: true,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter goal';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('Voeg bestanden toe'),
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
