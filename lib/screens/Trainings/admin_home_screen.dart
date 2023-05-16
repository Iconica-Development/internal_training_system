import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/screens/Trainings/create_training_screen.dart';

import '../login_screen.dart';

class BeheerScreen extends StatefulWidget {
  const BeheerScreen({super.key});

  @override
  State<BeheerScreen> createState() => _BeheerScreenState();
}

class _BeheerScreenState extends State<BeheerScreen> {
  final List<List<List<String>>> gridTitles = [
    [
      ['Training inplannen', '/plan_training'],
      ['Training aanmaken', '/create_training'],
      ['Training aanpassen', '/login'],
      ['Item 4', 'LINK'],
    ],
    [
      ['Training aanpassen', 'LINK'],
      ['Item 4', 'LINK'],
    ],
  ];

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Redirect the user to the login page
      return LoginExample();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Beheer',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        textStyle: const TextStyle(color: Color(0xFF71C6D1))),
                  ),
                ),
              ),
              buildGrid('Training', gridTitles[0]),
              SizedBox(height: 16),
              buildGrid('Admin', gridTitles[1]),
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
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        SizedBox(height: 32),
      ],
    );
  }

  Widget buildGridTitle(String gridCategoryName) {
    return Text(
      gridCategoryName,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildInkWellCard(String title, String link) {
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
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
