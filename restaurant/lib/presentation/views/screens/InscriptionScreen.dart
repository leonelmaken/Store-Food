import 'package:flutter/material.dart';
import 'package:restaurant/core/error/execeptions.dart';
import 'package:restaurant/domain/entities/user.dart';
import 'package:restaurant/domain/usecases/register_user_usecase.dart';
import 'package:restaurant/data/repositories/user_repository_impl.dart';
import 'package:restaurant/data/sources/user_remote_data_source.dart';
import 'package:http/http.dart' as http;

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _positionController = TextEditingController(); // Controller pour le poste
  
  String? _errorMessage;
  bool _isLoading = false;
  String? _role; // Variable pour stocker le rôle sélectionné

  late final UserRemoteDataSource _userRemoteDataSource;
  late final UserRepositoryImpl _userRepository;
  late final RegisterUserUseCase _registerUserUseCase;

  @override
  void initState() {
    super.initState();
    final client = http.Client();
    _userRemoteDataSource = UserRemoteDataSource(client);
    _userRepository = UserRepositoryImpl(_userRemoteDataSource);
    _registerUserUseCase = RegisterUserUseCase(_userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[900]!, Colors.grey[800]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 16),
              _buildTextField(_nameController, 'Nom'),
              const SizedBox(height: 16),
              _buildTextField(_telController, 'Téléphone'),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, 'Mot de passe', isObscured: true),
              const SizedBox(height: 20),
              // Choix du rôle
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Rôle',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: 'Employé', child: Text('Employé')),
                  DropdownMenuItem(value: 'Client', child: Text('Client')),
                ],
                onChanged: (value) {
                  setState(() {
                    _role = value; // Mise à jour du rôle sélectionné
                    _positionController.clear(); // Réinitialiser le champ du poste
                  });
                },
              ),
              const SizedBox(height: 16),
              // Champ pour le poste, visible si le rôle est "Employé"
              if (_role == 'Employé') ...[
                _buildTextField(_positionController, 'Poste'),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : () async {
                  setState(() {
                    _isLoading = true;
                  });

                  final user = User(
                    email: _emailController.text,
                    name: _nameController.text,
                    tel: _telController.text, // Ajouter le téléphone
                    password: _passwordController.text,
                    id: '',
                    position: _role == 'Employé' ? _positionController.text : null, // Ajouter le poste si rôle est "Employé"
                  );

                  try {
                    await _registerUserUseCase.call(user);
                    Navigator.pop(context);
                  } on ServerException catch (e) {
                    setState(() {
                      _errorMessage = e.message;
                      _isLoading = false;
                    });
                  } catch (e) {
                    setState(() {
                      _errorMessage = "Une erreur inattendue s'est produite";
                      _isLoading = false;
                    });
                  }
                },
                child: _isLoading 
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : const Text('S\'inscrire'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Coins arrondis
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null) ...[
                const SizedBox(height: 20),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isObscured = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscured,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
    );
  }
}
