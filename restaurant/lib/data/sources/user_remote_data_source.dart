// user_remote_data_source.dart

import 'dart:convert'; // Pour le décodage JSON
import 'package:http/http.dart' as http; // Pour faire des requêtes HTTP
import 'package:restaurant/core/error/execeptions.dart';
import 'package:restaurant/domain/entities/user.dart';


/// Classe qui gère les interactions avec l'API pour les utilisateurs.
class UserRemoteDataSource {
  final http.Client client; // Client HTTP pour effectuer les requêtes

  UserRemoteDataSource(this.client); // Constructeur

  /// Enregistre un nouvel utilisateur en appelant l'API.
  ///
  /// Renvoie un [User] créé si la requête réussit.
  /// Lance une [ServerException] en cas d'échec.
  Future<User> registerUser(User user) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/users/register'), // Remplacez par l'URL de votre API
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()), // Convertit l'utilisateur en JSON
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body)); // Crée un User à partir de la réponse JSON
    } else {
      throw ServerException("Erreur lors de l'enregistrement de l'utilisateur."); // Passer un message d'erreur
    }
  }

  /// Connecte un utilisateur en appelant l'API.
  ///
  /// Renvoie un [User] connecté si la requête réussit.
  /// Lance une [ServerException] en cas d'échec.
  Future<User> loginUser(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/users/login'), // Remplacez par l'URL de votre API
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }), // Encode l'email et le mot de passe en JSON
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)); // Crée un User à partir de la réponse JSON
    } else {
      throw ServerException("Erreur lors de la connexion de l'utilisateur."); // Passer un message d'erreur
    }
  }

  /// Récupère un utilisateur par son identifiant.
  ///
  /// Renvoie un [User] si la requête réussit.
  /// Lance une [ServerException] en cas d'échec.
  Future<User> getUserById(String id) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/users/$id'), // Remplacez par l'URL de votre API
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)); // Crée un User à partir de la réponse JSON
    } else {
      throw ServerException("Erreur lors de la récupération de l'utilisateur."); // Passer un message d'erreur
    }
  }

  /// Met à jour un utilisateur en appelant l'API.
  ///
  /// Renvoie un [User] mis à jour si la requête réussit.
  /// Lance une [ServerException] en cas d'échec.
  Future<User> updateUser(User user) async {
    final response = await client.put(
      Uri.parse('https://api.example.com/users/${user.id}'), // Remplacez par l'URL de votre API
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()), // Convertit l'utilisateur en JSON
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)); // Crée un User à partir de la réponse JSON
    } else {
      throw ServerException("Erreur lors de la mise à jour de l'utilisateur."); // Passer un message d'erreur
    }
  }
}
