import 'package:brummaps/googleMaps/google_maps_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("Ouvrir la map"),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Stack(
                children: [
                  Stack(
                    children: const <Widget>[GoogleMapsPage()],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // Stack(
      //   children: <Widget>[
      //     GoogleMapsPage()
      //   ],
      // ),
    );
  }
}
