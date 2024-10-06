// exceptions.dart

/// Exception générique pour gérer les erreurs dans l'application.
/// Elle peut être utilisée pour lever des erreurs lorsque des opérations
/// échouent et qu'aucune autre exception spécifique n'est applicable.
class AppException implements Exception {
  /// Message d'erreur pour décrire l'exception.
  final String message;

  /// Constructeur de la classe [AppException].
  AppException(this.message);

  @override
  String toString() {
    return 'AppException: $message';
  }
}

/// Exception pour gérer les erreurs de connexion.
/// Utilisée lorsque l'utilisateur n'a pas de connexion à internet
/// ou que la connexion échoue pour une autre raison.
class ConnectionException extends AppException {
  ConnectionException(String message) : super(message);

  @override
  String toString() {
    return 'ConnectionException: $message';
  }
}

/// Exception pour gérer les erreurs de validation.
/// Utilisée lorsqu'une opération échoue en raison de données invalides,
/// par exemple des entrées utilisateur incorrectes.
class ValidationException extends AppException {
  ValidationException(String message) : super(message);

  @override
  String toString() {
    return 'ValidationException: $message';
  }
}

/// Exception pour gérer les erreurs de serveur.
/// Utilisée lorsqu'il y a une erreur de serveur lors de l'exécution d'une opération.
class ServerException extends AppException {
  ServerException(String message) : super(message);

  @override
  String toString() {
    return 'ServerException: $message';
  }
}
