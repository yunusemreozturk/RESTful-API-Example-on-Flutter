import 'package:get/get.dart';

import '../service/user_service.dart';
import '../viewmodels/user_view_models.dart';

class StartApp {
  static void onAppStart() {
    Get.lazyPut(() => UserViewModel(), fenix: true);
    Get.lazyPut(() => UserService(), fenix: true);
  }
}
