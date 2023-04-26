import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/screens/Trainings/create_training_screen.dart';

class BeheerScreen extends StatefulWidget {
  const BeheerScreen({super.key});

  @override
  State<BeheerScreen> createState() => _BeheerScreenState();
}

class _BeheerScreenState extends State<BeheerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 140, right: 140),
        child: Column(children: [
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
          Expanded(
            child: const CardGrid(
              titles: [
                'Training inplannen',
                'Training aanmaken',
                'test',
                'test',
                'test',
                'test',
                'test'
              ],
              links: [
                'LINK ',
                'Training aanmaken',
                'test',
                'test',
                'test',
                'test',
                'test'
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Admin',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    textStyle: const TextStyle(color: Colors.blue)),
              ),
            ),
          ),
        ]));
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String link;

  const CardWidget({required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint(link);
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

class CardGrid extends StatelessWidget {
  final List<String> titles;
  final List<String> links;

  const CardGrid({required this.titles, required this.links});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemCount: titles.length,
      itemBuilder: (BuildContext context, int index) {
        return CardWidget(
          title: titles[index],
          link: links[index],
        );
      },
    );
  }
}
