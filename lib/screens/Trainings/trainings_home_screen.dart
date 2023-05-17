import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:web_application/screens/login_screen.dart';

import '../../datasource/trainings/training_datasource.dart';
import '../../services/training_service.dart';

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

  List<List<String>> myApplicaitonTiles = [];
  List<List<String>> upcomingTrainingsTiles = [];
  List<List<String>> myFollowedTrainingsTiles = [
    ['TEST training', '10-10-2000', 'LINK'],
    ['TEST training', '10-10-2000', 'LINK'],
    ['TEST training', '10-10-2000', 'LINK'],
  ];

  Future<List<List<String>>> fillMyApplicationTiles() async {
    var trainings =
        await trainingService.getAllTrainingApplications(user.email!);
    List<List<String>> trainingTiles = [];
    trainings.forEach((trainingData) {
      print(trainingData.startDate);

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

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginExample();
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    myApplicaitonTiles = snapshot.data ?? [];
                    return buildGrid(
                      'Mijn inschrijvingen',
                      myApplicaitonTiles,
                    );
                  }
                },
              ),
              FutureBuilder<List<List<String>>>(
                future: fillUpcomingTrainings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

  Widget buildInkWellCard(String title, String trainingDate, String link) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Color(0xFFB8E2E8),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        hoverColor: Color.fromARGB(255, 84, 149, 157),
        onTap: () {
          context.go(link);
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
