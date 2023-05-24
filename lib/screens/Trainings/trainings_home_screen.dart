import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rbac_services/flutter_rbac_services.dart';
import 'package:flutter_rbac_services_firebase/flutter_rbac_services_firebase.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:web_application/screens/login_screen.dart';

import '../../datasource/trainings/training_datasource.dart';
import '../../services/training_service.dart';
import '../not_allowed_screen.dart';

class Trainings extends StatefulWidget {
  const Trainings({super.key});

  @override
  State<Trainings> createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  var user = FirebaseAuth.instance.currentUser!;
  var trainingService = TrainingService(
    TrainingDatasource(firebaseApp: Firebase.app()),
  );

  List<List<String>> myApplicationTiles = [];
  List<List<String>> upcomingTrainingsTiles = [];
  List<List<String>> myFollowedTrainingsTiles = [
    ['TEST training', 'PLACEHOLDER', '/training_application'],
    ['TEST training', 'PLACEHOLDER', '/training_application'],
    ['TEST training', 'PLACEHOLDER', '/training_application'],
  ];

  Future<List<List<String>>> fillMyApplicationTiles() async {
    var trainings =
        await trainingService.getAllTrainingApplications(user.email!);
    List<List<String>> trainingTiles = [];
    trainings.forEach((trainingData) {
      List<String> trainingTile = [
        trainingData.trainingName,
        trainingData.startDate.toString(),
        trainingData.id.toString(),
      ];
      trainingTiles.add(trainingTile);
    });

    return trainingTiles;
  }

  Future<List<List<String>>> fillUpcomingTrainings() async {
    var trainings = await trainingService.getAllTrainingsData();
    List<List<String>> trainingTiles = [];
    trainings.forEach((trainingData) {
      List<String> trainingTile = [
        trainingData.trainingName,
        trainingData.startDate.toString(),
        trainingData.id.toString(),
      ];
      trainingTiles.add(trainingTile);
    });

    return trainingTiles;
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
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'Trainingen',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              textStyle: const TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<List<List<String>>>(
                        future: fillMyApplicationTiles(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            myApplicationTiles = snapshot.data ?? [];
                            return buildGrid(
                              'Mijn inschrijvingen',
                              myApplicationTiles,
                            );
                          }
                        },
                      ),
                      FutureBuilder<List<List<String>>>(
                        future: fillUpcomingTrainings(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            upcomingTrainingsTiles = snapshot.data ?? [];
                            return buildGrid(
                              'Aankomende trainingen',
                              upcomingTrainingsTiles,
                            );
                          }
                        },
                      ),
                      buildGrid(
                        'Trainingen die ik heb gevolgd',
                        myFollowedTrainingsTiles,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  Widget buildGrid(String rowName, List<List<String>> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGridTitle(rowName),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 2,
          ),
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int gridIndex) {
            return buildInkWellCard(
                cards[gridIndex][0], cards[gridIndex][1], cards[gridIndex][2]);
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildGridTitle(String gridCategoryName) {
    return Text(
      gridCategoryName,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildInkWellCard(
      String title, String trainingDate, String trainingId) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Color(0xFFB8E2E8),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        hoverColor: Color.fromARGB(255, 84, 149, 157),
        onTap: () {
          context.go('/trainingdetails/' + trainingId);
        },
        child: SizedBox(
          width: 400,
          height: 250,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 30),
                ),
                Text(
                  trainingDate,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
