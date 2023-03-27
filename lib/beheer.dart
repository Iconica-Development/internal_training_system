import 'package:flutter/material.dart';

class BeheerScreen extends StatefulWidget {
  const BeheerScreen({super.key});

  @override
  State<BeheerScreen> createState() => _BeheerScreenState();
}

class _BeheerScreenState extends State<BeheerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Text('BEHEER')),
    );
  }
}