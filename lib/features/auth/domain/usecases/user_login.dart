
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '/core/error/failures.dart';

import '/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/usecase/usecases.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
