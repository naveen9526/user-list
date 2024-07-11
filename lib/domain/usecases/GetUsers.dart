import 'package:user_listing_app/data/models/UserModel.dart';
import 'package:user_listing_app/data/repositories/UserRepository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<UserModel>> call(int page) async {
    return await repository.fetchUsers(page);
  }
}
