import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTraining extends StatefulWidget {
  const CreateTraining({super.key});

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.grey[200],
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        // ),
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Training aanmaken',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                        textStyle:
                                            const TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Naam training',
                                  ),
                                ),
                              ),
                              const TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Omschrijving training',
                                ),
                              ),
                              const SizedBox(height: 15),
                              OutlinedButton(
                                onPressed: () {},
                                child: const Text('Voeg bestanden toe'),
                              ),
                              const SizedBox(height: 15),
                              FilledButton(
                                onPressed: () {},
                                child: const Text('Training aanmaken'),
                              ),
                            ]),
                      )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
