// user.dart

class User {
  final String id; // Identifiant de l'utilisateur
  final String email; // Adresse e-mail de l'utilisateur
  final String password; // Mot de passe de l'utilisateur (à ne pas stocker en clair)
  final String name; // Nom de l'utilisateur
  final String tel; // Numéro de téléphone de l'utilisateur
  final String? position; // Poste de l'utilisateur, peut être nul pour les clients

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.tel,
    this.position, // Le poste est optionnel
  });

  /// Méthode pour créer un utilisateur à partir d'un objet JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Assurez-vous que la clé 'id' existe dans votre JSON
      email: json['email'], // Assurez-vous que la clé 'email' existe dans votre JSON
      password: json['password'], // Assurez-vous que la clé 'password' existe dans votre JSON
      name: json['name'], // Assurez-vous que la clé 'name' existe dans votre JSON
      tel: json['tel'], // Assurez-vous que la clé 'tel' existe dans votre JSON
      position: json['position'], // Assurez-vous que la clé 'position' existe dans votre JSON
    );
  }

  /// Méthode pour convertir un utilisateur en objet JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'tel': tel, // Ajout du numéro de téléphone dans le JSON
      'position': position, // Ajout du poste dans le JSON
    };
  }
}
