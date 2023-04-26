import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Trainings extends StatefulWidget {
  const Trainings({super.key});

  @override
  State<Trainings> createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  final List<List<String>> gridTitles = [
    ['Firebase training', 'Item 2', 'Item 3', 'Item 4', 'Item 5'],
    ['Flutter Basics', 'Item 7', 'Item 8'],
  ];

  @override
  Widget build(BuildContext context) {
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
                    'Trainingen',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        textStyle: const TextStyle(color: Colors.blue)),
                  ),
                ),
              ),
              buildGrid('Mijn inschrijvingen', gridTitles[0]),
              SizedBox(height: 16),
              buildGrid('Aankomende trainingen', gridTitles[1]),
              buildGrid('Trainingen die ik heb gevolgd', gridTitles[1]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGrid(String rowName, List<String> cards) {
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
            return buildInkWellCard(cards[gridIndex]);
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

  Widget buildInkWellCard(String title) {
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
