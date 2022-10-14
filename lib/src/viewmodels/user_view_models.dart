import 'package:get/get.dart';
import 'package:restful_example/src/service/user_service.dart';

import '../models/user_model.dart';

class UserViewModel extends GetxController {
  final UserService _userService = UserService();
  Rx<UserModel?> userModelUpper = UserModel().obs;

  Future<UserModel?> fetchUsers() async {
    try {
      UserModel? userModelInner = await _userService.fetchUsers();

      userModelUpper.value = userModelInner;
      return userModelInner;
    } catch (e) {
      print('Error: UserViewModel(fetchUsers): ${e.toString()}');
    }
  }

  Stream<UserModel?> userStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield await fetchUsers();
    }
  }

  Future<bool?> addUser(UserModelData userModelData) async {
    try {
      var res = await _userService.addUser(userModelData);

      if (res != null) {
        userModelUpper.value = res;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: UserViewModel(addUser): ${e.toString()}');
    }
  }

  Future<bool?> deleteUser(String id) async {
    try {
      var res = await _userService.deleteUser(id);

      if (res != null) {
        userModelUpper.value = res;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: userViewModel(deleteUser): ${e.toString()}');
    }
  }
}
