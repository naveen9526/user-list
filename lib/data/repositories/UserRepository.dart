import 'package:user_listing_app/data/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  final String baseUrl = 'https://reqres.in/';

  Future<List<UserModel>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('${baseUrl}api/users?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> userList = data['data'];

      return userList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel> fetchUserDetail(int userId) async {
    final response = await http.get(Uri.parse('${baseUrl}api/users/$userId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user detail');
    }
  }
}
