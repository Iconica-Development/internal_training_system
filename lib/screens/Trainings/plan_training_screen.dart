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

var trainingService = TrainingService(
  TrainingDatasource(firebaseApp: Firebase.app()),
);

class _PlanTrainingState extends State<PlanTraining> {
  final _formKey = GlobalKey<FormState>();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String trainingNameValue = '';
  String trainerDropdownValue = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await trainingService.createTrainingPlanning(
          trainingNameValue, trainerDropdownValue, startDate, endDate);

      context.go('/admin');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully.'),
        ),
      );
    }
  }

  Future<List<String>> getAllTrainings() async {
    List<String> listOfTrainings = [];
    var trainings = await trainingService.getAllTrainingsData();
    trainings.forEach((trainingData) {
      // Access and work with trainingData properties
      listOfTrainings.add(trainingData.trainingName);
    });
    return listOfTrainings;
  }

  List<String> listOfTrainers = ['Trainer 1', 'Trainer 2'];

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginExample();
    }

    return FutureBuilder<List<String>>(
        future: getAllTrainings(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while fetching data
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle the error case
            return Text('Error: ${snapshot.error}');
          } else {
            // Data has been fetched successfully
            List<String> listOfTrainings = snapshot.data!;
            if (trainingNameValue.isEmpty) {
              trainingNameValue = listOfTrainings.first;
            }
            if (trainerDropdownValue.isEmpty) {
              trainerDropdownValue = listOfTrainers.first;
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
                                                  const EdgeInsets.all(4.0),
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
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'Training kiezen',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  textStyle: const TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: trainingNameValue,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                trainingNameValue = value!;
                                              });
                                            },
                                            items: listOfTrainings
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'Trainer kiezen',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  textStyle: const TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: trainerDropdownValue,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                trainerDropdownValue = value!;
                                              });
                                            },
                                            items: listOfTrainers
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: ElevatedButton(
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
                                                child: Text(
                                                    'Selecteer start datum')),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Start datum: ${startDate.day}-${startDate.month}-${startDate.year}'),
                                          ),
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
                                                  endDate = newDate;
                                                });
                                              },
                                              child:
                                                  Text('Selecteer eind datum')),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Eind datum: ${endDate.day}-${endDate.month}-${endDate.year}'),
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
