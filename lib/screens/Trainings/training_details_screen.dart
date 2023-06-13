import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rbac_services/flutter_rbac_services.dart';
import 'package:flutter_rbac_services_firebase/flutter_rbac_services_firebase.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web_application/datasource/trainings/training_datasource.dart';
import 'package:web_application/screens/Trainings/plan_training_screen.dart';
import 'package:web_application/services/training_service.dart';

import '../../services/training_planning_data_model.dart';
import '../login_screen.dart';
import '../not_allowed_screen.dart';

class TrainingDetails extends StatefulWidget {
  final String id;
  TrainingDetails({required this.id, super.key});

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
  var user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  var trainingService = TrainingService(
    TrainingDatasource(firebaseApp: Firebase.app()),
  );

  Future<TrainingPlanningDataModel?> getTrainingById(String id) {
    return trainingService.getTrainingById(id);
  }

  void _submitForm(String planningId) async {
    if (_formKey.currentState!.validate()) {
      trainingService.createTrainingApplication(planningId, user.email!);

      context.go('/trainings');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully.'),
        ),
      );
    }
  }

  Future<bool> getUserPermission(String userId, String roleId) async {
    FirebaseApp firebaseApp = Firebase.app();
    var firebaseDatasource = FirebaseRbacDatasource(firebaseApp: firebaseApp);
    var rbacService = RbacService(firebaseDatasource);
    print('CURRENT USER ID: ' + userId);
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
            return FutureBuilder<TrainingPlanningDataModel?>(
                future: getTrainingById(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final training = snapshot.data;
                    if (training == null) {
                      return Text('Training not found');
                    }
                    DateTime startDate = training.startDate;
                    DateTime endDate = training.endDate;
                    String convertedStartDateTime =
                        "${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year.toString()} ${startDate.hour.toString().padLeft(2, '0')}:${startDate.minute.toString().padLeft(2, '0')}";
                    String convertedEndDateTime =
                        "${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year.toString()} ${startDate.hour.toString().padLeft(2, '0')}:${startDate.minute.toString().padLeft(2, '0')}";

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
                                                          const EdgeInsets.all(
                                                              18.0),
                                                      child: Text(
                                                        training.trainingName,
                                                        style: GoogleFonts.roboto(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 25,
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Training omschrijving: PLACEHOLDER',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    'Trainer: ' +
                                                        training.trainerName,
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    'Start datum: ' +
                                                        convertedStartDateTime,
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    'Eind datum: ' +
                                                        convertedEndDateTime,
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  FilledButton(
                                                    onPressed: () =>
                                                        _submitForm(
                                                            training.id),
                                                    child: const Text(
                                                        'Inschrijven'),
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
        });
  }
}
