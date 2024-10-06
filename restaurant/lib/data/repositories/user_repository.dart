// user_repository.dart

import 'package:dartz/dartz.dart';
import 'package:restaurant/domain/entities/user.dart';
import '../../core/error/failures.dart';

/// Interface du UserRepository qui définit les méthodes
/// liées à la gestion des utilisateurs.
/// Cette interface permet d'abstraire la source des données
/// (API, base de données locale, etc.) et facilite les tests
/// en permettant l'utilisation de mocks.

abstract class UserRepository {
  
  /// Méthode pour enregistrer un nouvel utilisateur.
  /// Elle prend un objet [User] et renvoie soit un [Failure]
  /// en cas d'erreur, soit l'objet [User] créé.
  Future<Either<Failure, User>> registerUser(User user);

  /// Méthode pour connecter un utilisateur.
  /// Elle prend un email et un mot de passe, et renvoie soit un [Failure]
  /// en cas d'erreur (par exemple, mauvais identifiants), soit l'objet [User]
  /// si la connexion est réussie.
  Future<Either<Failure, User>> loginUser(String email, String password);

  /// Méthode pour récupérer les informations d'un utilisateur
  /// à partir de son identifiant unique [id].
  /// Elle renvoie soit un [Failure] en cas d'échec, soit un [User].
  Future<Either<Failure, User>> getUserById(String id);

  /// Méthode pour mettre à jour les informations d'un utilisateur.
  /// Elle prend un objet [User] mis à jour et renvoie soit un [Failure]
  /// en cas d'échec, soit le [User] modifié.
  Future<Either<Failure, User>> updateUser(User user);
}
