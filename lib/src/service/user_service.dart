import 'dart:convert';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String localUrl = 'http://192.168.43.166:3000/users';

  Future<UserModel?> fetchUsers() async {
    try {
      var res = await http.get(Uri.parse(localUrl));

      if (res.statusCode == 200) {
        var jsonBody = UserModel.fromJson({"users": jsonDecode(res.body)});

        return jsonBody;
      } else {
        print('Error: UserService(fetchUsers) statusCode: ${res.statusCode}');
      }
    } catch (e) {
      print('Error: UserService(fetchUsers): ${e.toString()}');
    }
  }

  Future<UserModel?> addUser(UserModelData userModelData) async {
    try {
      var res = await http.post(
        Uri.parse(localUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userModelData.toJson()),
      );

      if (res.statusCode == 201) {
        print(jsonDecode(res.body));
        var jsonBody = UserModel.fromJson(jsonDecode(res.body));

        return jsonBody;
      } else {
        print('Error: UserService(addUser) statusCode: ${res.statusCode}');
      }
    } catch (e) {
      print('Error: UserService(addUser): ${e.toString()}');
    }
  }

  deleteUser(String name) async {
    var res =
        await http.delete(Uri.parse(localUrl + name), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}
