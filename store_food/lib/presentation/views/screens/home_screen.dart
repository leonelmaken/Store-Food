import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // Le corps de la page contient un carrousel d'images, des boutons et une grille de plats.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrousel en entête avec 5 images de plats
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: ['boeuf rotis.jpeg', 'poisson rotis.jpeg', 'pomme.jpeg', 'poulet rotis.png', 'salade.png', 'spagettis.jpeg'].map((imagePath){
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.green, // Ajout de couleur verte comme demandé
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

            SizedBox(height: 20),

            // Boutons "S'inscrire" et "Se connecter"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action pour s'inscrire
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('S\'inscrire'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Action pour se connecter
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('Se connecter'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // GridView de 2 colonnes et 6 lignes avec des images de plats
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true, // Nécessaire pour que la grille ne prenne pas tout l'espace
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 colonnes
                  childAspectRatio: 3 / 2, // Pour adapter la taille des cartes
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 12, // 6 lignes avec 2 colonnes = 12 plats
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/plat${index + 1}.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Plat ${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.bold),
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

      // Barre de navigation en bas de l'écran
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promotions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
}
