import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<Widget>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
