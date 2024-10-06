import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'package:restaurant/presentation/views/screens/InscriptionScreen.dart';
import 'package:restaurant/presentation/views/screens/LoginScreen.dart';
import 'package:restaurant/presentation/widgets/custom_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true; // Indique si la page est en chargement
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialisation de l'AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Animation de disparition du texte
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Démarrer l'animation et changer l'état après 3 secondes
    _controller.forward();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false; // Arrêt de l'animation de chargement après 3 secondes
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // Méthode pour afficher la barre de recherche avec une animation fluide
  void _showSearchBar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Pour que le bottom sheet puisse s'étendre pleinement
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Effectuer la recherche ici
                      Navigator.of(context).pop(); // Fermer la barre de recherche après la recherche
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Rechercher'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fermer la barre de recherche sans action
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Annuler'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
Route _createLoginRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // De droite à gauche
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Accueil', style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      
      body: _isLoading
          ? Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Food Store',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.withOpacity(0.7), // Couleur du texte
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Carousel d'images
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      'boeuf rotis.jpeg',
                      'poisson rotis.jpeg',
                      'pomme.jpeg',
                      'poulet rotis.png',
                      'salade.png',
                      'spagettis.jpeg'
                    ].map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Image.asset(
                              'assets/$imagePath',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigation avec animation
                          Navigator.of(context).push(_createRoute());
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('S\'inscrire'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
  onPressed: () {
    Navigator.of(context).push(_createLoginRoute());
  },
  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  child: const Text('Se connecter'),
),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        final imagePath = 'assets/plat${index + 1}.jpg';

                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Plat ${index + 1}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Appel de la méthode pour afficher la barre de recherche
                _showSearchBar();
              },
              child: const Icon(Icons.search),
            ),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promotions',
          ),
           BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                // Redirection vers la page d'accueil
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Icon(Icons.home),
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const InscriptionScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // De bas en haut
        const end = Offset.zero; // Fin à la position d'origine
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
