import 'package:flutter/material.dart';
import 'package:flutter_sqflite/user_controller.dart';
import 'package:get/get.dart';

class UserListWidget extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Obx(() => ListView.builder(
            itemCount: userController.users.length,
            itemBuilder: (context, index) {
              var user = userController.users[index];
              return ListTile(
                title: Text(user.username ?? ""),
                subtitle: Text(user.password ?? ""),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // Show a dialog to add a new user
          TextEditingController usernameController = TextEditingController();
          TextEditingController passwordController = TextEditingController();
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add user'),
                  content: Column(children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                  ]),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        String username = usernameController.text;
                        String password = passwordController.text;
                        if (username.isNotEmpty && password.isNotEmpty) {
                          await userController.addUser(username, password);
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar("Error", "Please enter valid data!");
                        }
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
