import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_application/screens/create_user_screen.dart';
import 'package:web_application/screens/login_screen.dart';
import 'package:web_application/screens/Trainings/admin_home_screen.dart';
import 'package:web_application/screens/Trainings/create_training_screen.dart';
import 'package:web_application/screens/Trainings/trainings_home_screen.dart';
import 'package:web_application/screens/logout_screen.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.child, {super.key});
  final Widget child; // Get “child” since it'll be given based on route path
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(52.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xFF71C6D1),
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 52.0),
              ],
            ),
            child: NavigationRail(
              backgroundColor: Color(0xFF71C6D1),
              onDestinationSelected: (value) {
                switch (value) {
                  case 0:
                    context.go('/trainings');
                    break;
                  case 1:
                    context.go('/admin');
                    break;
                  case 2:
                    context.go('/create_training');
                    break;
                  case 3:
                    context.go('/logout');
                }
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.school,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Trainings',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.text_snippet,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Admin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.opacity,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              selectedIndex: _calculateSelectedIndex(context),
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/trainings')) {
      return 0;
    }
    if (location.startsWith('/admin')) {
      return 1;
    }
    if (location.startsWith('/logout')) {
      return 2;
    }
    return 0;
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  initialLocation: '/trainings',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavbar(child);
      },
      routes: <RouteBase>[
        GoRoute(
            path: '/trainings',
            pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const Trainings(),
                ),
            routes: [
              GoRoute(
                path: 'create_training',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const CreateTraining(),
                ),
              ),
            ]),
        GoRoute(
          path: '/logout',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const LogoutScreen(),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const LoginExample(),
          ),
        ),
        GoRoute(
          path: '/admin',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const BeheerScreen(),
          ),
        ),
        GoRoute(
          path: '/create_training',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const LogoutScreen(),
          ),
        ),
        GoRoute(
          path: '/create_user',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const CreateUser(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginExample(),
    ),
  ],
);
