import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Trainings extends StatefulWidget {
  const Trainings({super.key});

  @override
  State<Trainings> createState() => _TrainingsState();
}

class _TrainingsState extends State<Trainings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 140, right: 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            'Mijn inschrijvingen',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 42,
                textStyle: TextStyle(color: Colors.blue)),
          ),
          GetAllSubscribedTrainings(),
          Text(
            'Beschikbare trainingen',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 42,
                textStyle: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

class GetAllSubscribedTrainings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(140.0),
      child: Expanded(
        child: Wrap(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Firebase');
                },
                child: SizedBox(
                  width: 400,
                  height: 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Firebase',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(
                          '10-10-2023',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Firebase');
                },
                child: SizedBox(
                  width: 400,
                  height: 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Flutter Basics',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(
                          '10-10-2023',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
