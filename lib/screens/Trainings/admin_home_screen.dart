import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rbac_services/flutter_rbac_services.dart';
import 'package:flutter_rbac_services_firebase/flutter_rbac_services_firebase.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_application/screens/not_allowed_screen.dart';

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
      ['Maak gebruiker aan', '/create_user'],
    ],
    [
      ['Training aanpassen', 'LINK'],
      ['Genereer certificaat', 'LINK'],
    ],
  ];

  Future<bool> getUserPermission(String userId, String roleId) async {
    FirebaseApp firebaseApp = Firebase.app();
    var firebaseDatasource = FirebaseRbacDatasource(firebaseApp: firebaseApp);
    var rbacService = RbacService(firebaseDatasource);
    bool hasPermission = await rbacService.hasRole(userId, roleId);
    return hasPermission;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginExample();
    }

    return FutureBuilder<bool>(
      future: getUserPermission(user.uid, 'Iv7eRUhqS9zx5aibgGUd'),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isAllowed = snapshot.data ?? false;
          if (!isAllowed) {
            return NotAllowedScreen();
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
                              textStyle:
                                  const TextStyle(color: Color(0xFF71C6D1))),
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
      },
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
