import 'package:flutter_sqflite/database_handler.dart';
import 'package:flutter_sqflite/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserService _service = UserService();
  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the users list when the controller is created
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    users.value = await _service.getUsers();
  }

  Future<int> addUser(String username, String password) async {
    int result = await _service.addUser(username, password);
    if (result > 0) {
      // Reload the users list after adding a new user
      await fetchUsers();
    }
    return result;
  }

  Future<int> updateUser(User user) async {
    int result = await _service.updateUser(user);
    if (result > 0) {
      // Reload the users list after updating a user
      await fetchUsers();
    }
    return result;
  }

  Future<int> deleteUser(int id) async {
    int result = await _service.deleteUser(id);
    if (result > 0) {
      // Reload the users list after deleting a user
      await fetchUsers();
    }
    return result;
  }
}
