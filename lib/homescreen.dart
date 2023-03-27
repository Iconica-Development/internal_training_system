import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: Column(
          children: const <Widget>[
            MenuCards(),
          ],
        ),
      ),
    );
  }
}

class MenuCards extends StatelessWidget {
  const MenuCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(140.0),
      child: Expanded(
        child: Wrap(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 400,
                  height: 250,
                  child: Center(
                      child: Text(
                    'Trainingen',
                    style: TextStyle(fontSize: 40),
                  )),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 400,
                  height: 250,
                  child: Center(
                      child: Text(
                    'Beheer',
                    style: TextStyle(fontSize: 40),
                  )),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 400,
                  height: 250,
                  child: Center(
                      child: Text(
                    'Trainings',
                    style: TextStyle(fontSize: 40),
                  )),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 400,
                  height: 250,
                  child: Center(
                      child: Text(
                    'Trainings',
                    style: TextStyle(fontSize: 40),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
