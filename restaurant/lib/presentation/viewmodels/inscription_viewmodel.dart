import 'package:flutter/material.dart';
import 'package:restaurant/core/error/execeptions.dart';
import 'package:restaurant/domain/usecases/register_user_usecase.dart';
import 'package:restaurant/domain/entities/user.dart';

class InscriptionViewModel extends ChangeNotifier {
  final RegisterUserUseCase _registerUserUseCase;

  // Champs d'état pour l'inscription
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _name = ''; // Nouveau champ pour le nom
  String _tel = ''; // Nouveau champ pour le numéro de téléphone
  String? _position; // Poste, nul si ce n'est pas un employé
  String _role = 'client'; // Rôle par défaut, peut être 'client' ou 'employé'
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get name => _name; // Getter pour le nom
  String get tel => _tel; // Getter pour le numéro de téléphone
  String? get position => _position; // Getter pour le poste
  String get role => _role; // Getter pour le rôle
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Constructeur
  InscriptionViewModel(this._registerUserUseCase);

  // Méthodes de mise à jour des champs
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setTel(String tel) {
    _tel = tel;
    notifyListeners();
  }

  void setPosition(String? position) {
    _position = position; // Peut être nul si l'utilisateur est un client
    notifyListeners();
  }

  void setRole(String role) {
    _role = role; // Met à jour le rôle de l'utilisateur
    notifyListeners();
  }

  // Méthode pour gérer l'inscription
  Future<void> register() async {
    if (_password != _confirmPassword) {
      _errorMessage = "Les mots de passe ne correspondent pas";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Créer un nouvel utilisateur avec toutes les informations
      await _registerUserUseCase.call(User(
        email: _email,
        password: _password,
        id: '', // Assurez-vous de générer ou de récupérer un ID si nécessaire
        name: _name,
        tel: _tel,
        position: _role == 'employé' ? _position : null, // Assurez-vous d'envoyer le poste uniquement si c'est un employé
      ));
      _errorMessage = null; // Réinitialiser le message d'erreur en cas de succès
    } on ServerException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = "Une erreur inattendue s'est produite";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
