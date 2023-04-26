import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_application/screens/Trainings/create_training_screen.dart';
import 'package:web_application/screens/Trainings/admin_home_screen.dart';
import 'package:web_application/screens/Trainings/trainings_home_screen.dart';
import 'firebase_options.dart';
import 'login_screen.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination>? destinations = <ExampleDestination>[
  ExampleDestination(
      'Trainingen', Icon(Icons.school_outlined), Icon(Icons.school)),
  ExampleDestination(
      'Beheer', Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
  ExampleDestination(
      'page 3', Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity)),
  1 == 2
      ? ExampleDestination(
          'GOED', Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity))
      : ExampleDestination(
          'FOUT', Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity)),
];

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: 'NavigationDrawer Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const NavigationDrawerExample(),
    ),
  );
}

class NavigationDrawerExample extends StatefulWidget {
  const NavigationDrawerExample({super.key});

  @override
  State<NavigationDrawerExample> createState() =>
      _NavigationDrawerExampleState();
}

class _NavigationDrawerExampleState extends State<NavigationDrawerExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;
  final List<Widget> screens = [
    Trainings(),
    const BeheerScreen(),
    const CreateTraining(),
    const LoginExample(),
  ];

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      print(selectedScreen);
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (screenIndex) =>
            setState(() => this.screenIndex = screenIndex),
        destinations: destinations!.map((ExampleDestination destination) {
          return NavigationDestination(
            label: destination.label,
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
            tooltip: destination.label,
          );
        }).toList(),
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: screens[screenIndex],
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Navigatie',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations!.map((ExampleDestination destination) {
            return NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          }),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openDrawer,
        label: const Text('Menu'),
        icon: const Icon(Icons.info_outline),
        backgroundColor: Colors.pink,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }
}
