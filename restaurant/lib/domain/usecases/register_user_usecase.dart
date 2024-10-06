// register_user_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:restaurant/data/repositories/user_repository.dart';
import '../entities/user.dart';
import '../../core/error/failures.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return await repository.registerUser(user);
  }
}
