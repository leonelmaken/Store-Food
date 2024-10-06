// lib/models/utilisateur.dart

class Utilisateur {
  final String nom;
  final String email;
  final String telephone;
  final String pays;
  final String localite;
  final int age;
  final String? poste;  // Peut être null si le rôle est "Client"
  final String role;     // "Employé" ou "Client"

  Utilisateur({
    required this.nom,
    required this.email,
    required this.telephone,
    required this.pays,
    required this.localite,
    required this.age,
    this.poste,          // Optionnel
    required this.role,
  });

  // Méthode pour vérifier si l'email est valide (ceci peut être déplacé dans ViewModel si nécessaire)
  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  // Méthode pour convertir l'utilisateur en un Map (utile pour les enregistrements dans une base de données, etc.)
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'pays': pays,
      'localite': localite,
      'age': age,
      'poste': poste,
      'role': role,
    };
  }

  // Méthode pour créer un Utilisateur à partir d'un Map
  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      nom: map['nom'],
      email: map['email'],
      telephone: map['telephone'],
      pays: map['pays'],
      localite: map['localite'],
      age: map['age'],
      poste: map['poste'],
      role: map['role'],
    );
  }
}
