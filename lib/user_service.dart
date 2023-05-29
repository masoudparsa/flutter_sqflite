import 'package:flutter_sqflite/database_handler.dart';

class UserService {
  DatabaseHandler _handler = DatabaseHandler();

  Future<int> addUser(String username, String password) async {
    User newUser = User(username: username, password: password);
    int result = await _handler.addUser(newUser);
    return result;
  }

  Future<int> updateUser(User user) async {
    int result = await _handler.updateUser(user);
    return result;
  }

  Future<int> deleteUser(int id) async {
    int result = await _handler.deleteUser(id);
    return result;
  }

  Future<List<User>> getUsers() async {
    List<User> users = await _handler.getUsers();
    return users;
  }
}
