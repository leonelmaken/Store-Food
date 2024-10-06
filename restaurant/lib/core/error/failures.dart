// failures.dart

/// Classe de base pour gérer les échecs (erreurs) dans l'application.
/// Elle est utilisée dans les méthodes qui renvoient un Either<Failure, T>
/// pour indiquer qu'une opération a échoué.
abstract class Failure {
  /// Message d'erreur ou toute autre information pertinente
  /// pour comprendre l'échec.
  final String message;

  /// Constructeur de la classe abstraite [Failure].
  Failure(this.message);
}

/// Échec lié à une erreur de serveur.
/// Cela peut arriver lorsqu'il y a un problème avec l'API
/// ou le backend lors de la récupération ou l'envoi de données.
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

/// Échec lié à la validation des données.
/// Par exemple, lorsque les informations fournies par
/// l'utilisateur ne respectent pas certaines contraintes
/// (comme un mot de passe trop court).
class ValidationFailure extends Failure {
  ValidationFailure(String message) : super(message);
}

/// Échec lié à une absence de connexion réseau.
/// Utilisé pour gérer les cas où l'utilisateur n'a pas de
/// connexion internet ou lorsqu'une tentative de connexion
/// au serveur échoue à cause du réseau.
class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

/// Échec lié à une tentative d'accès à des données locales.
/// Cela peut arriver lorsque l'application ne parvient pas
/// à lire ou écrire dans une base de données locale ou dans le stockage.
class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}

/// Échec générique.
/// Utilisé pour couvrir les cas où une erreur ne correspond
/// à aucune des catégories spécifiques définies ci-dessus.
class GenericFailure extends Failure {
  GenericFailure(String message) : super(message);
}
