import 'package:dartz/dartz.dart'; // Pour utiliser Either
import 'package:restaurant/data/sources/user_remote_data_source.dart'; // Import de la source de données distante
import 'package:restaurant/domain/entities/user.dart'; // Import de l'entité User
import 'package:restaurant/core/error/failures.dart'; // Import des échecs
import 'user_repository.dart'; // Import de l'interface UserRepository

/// Classe qui implémente UserRepository pour gérer les utilisateurs.
/// Cette classe utilise une source de données distante pour effectuer
/// les opérations CRUD sur les utilisateurs.
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource; // Source de données distante

  /// Constructeur de UserRepositoryImpl.
  /// Il prend une instance de UserRemoteDataSource en paramètre.
  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> registerUser(User user) async {
    try {
      // Appelle la méthode registerUser de la source de données distante
      final createdUser = await remoteDataSource.registerUser(user);
      return Right(createdUser); // Renvoie l'utilisateur créé
    } catch (e) {
      // En cas d'erreur, renvoie un échec du serveur
      // Vous pouvez ajouter une logique pour gérer différents types d'erreurs ici
      return Left(ServerFailure(e.toString())); // Transmet l'erreur pour un meilleur diagnostic
    }
  }

  @override
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    try {
      // Appelle la méthode loginUser de la source de données distante
      final loggedInUser = await remoteDataSource.loginUser(email, password);
      return Right(loggedInUser); // Renvoie l'utilisateur connecté
    } catch (e) {
      // En cas d'erreur, renvoie un échec du serveur
      return Left(ServerFailure(e.toString())); // Transmet l'erreur pour un meilleur diagnostic
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    try {
      // Appelle la méthode getUserById de la source de données distante
      final user = await remoteDataSource.getUserById(id);
      return Right(user); // Renvoie l'utilisateur trouvé
    } catch (e) {
      // En cas d'erreur, renvoie un échec du serveur
      return Left(ServerFailure(e.toString())); // Transmet l'erreur pour un meilleur diagnostic
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    try {
      // Appelle la méthode updateUser de la source de données distante
      final updatedUser = await remoteDataSource.updateUser(user);
      return Right(updatedUser); // Renvoie l'utilisateur mis à jour
    } catch (e) {
      // En cas d'erreur, renvoie un échec du serveur
      return Left(ServerFailure(e.toString())); // Transmet l'erreur pour un meilleur diagnostic
    }
  }
}
