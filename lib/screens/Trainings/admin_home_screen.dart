import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/screens/Trainings/create_training_screen.dart';

class BeheerScreen extends StatefulWidget {
  const BeheerScreen({super.key});

  @override
  State<BeheerScreen> createState() => _BeheerScreenState();
}

class _BeheerScreenState extends State<BeheerScreen> {
  final List<List<String>> gridTitles = [
    [
      'Training inplannen',
      'Training aanmaken',
      'Training aanpassen',
      'Item 4',
      'Item 5'
    ],
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
                    'Beheer',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        textStyle: const TextStyle(color: Colors.blue)),
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
