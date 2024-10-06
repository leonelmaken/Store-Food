import 'package:flutter/material.dart';
import 'package:restaurant/presentation/views/screens/home_screen.dart'; // Chemin d'importation correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Désactiver le bandeau "debug"
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 48, 47, 49)),
        useMaterial3: true,
      ),
      home: HomeScreen(), // Utilisation de HomeScreen comme page d'accueil
    );
  }
}