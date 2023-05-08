import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_application/screens/login_screen.dart';

class Trainings extends StatefulWidget {
  const Trainings({super.key});

  @override
  State<Trainings> createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  final List<List<List<String>>> gridTitles = [
    [
      ['Firebase training', '10-10-2000', 'LINK'],
      ['Firebase training', '10-10-2000', 'LINK'],
    ],
    [
      ['Firebase training', '10-10-2000', 'LINK'],
      ['Firebase training', '10-10-2000', 'LINK'],
    ],
    [
      ['Firebase training', '10-10-2000', 'LINK'],
      ['Firebase training', '10-10-2000', 'LINK'],
    ],
  ];

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
                        textStyle: const TextStyle(color: Colors.blue)),
                  ),
                ),
              ),
              buildGrid('Mijn inschrijvingen', gridTitles[0]),
              const SizedBox(height: 16),
              buildGrid('Aankomende trainingen', gridTitles[1]),
              buildGrid('Trainingen die ik heb gevolgd', gridTitles[2]),
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
            return buildInkWellCard(cards[gridIndex][0], cards[gridIndex][1]);
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

  Widget buildInkWellCard(String title, String trainingDate) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('s');
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
