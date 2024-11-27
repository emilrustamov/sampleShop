import 'package:edermanapp/model/user/user.dart';
import 'package:get/get.dart';

enum UserLoginStage { login, register, phone, code, anon }

class UserController extends GetxController {
  var user = Rx<UserModel?>(null);
  var userStage = Rx<UserLoginStage>(UserLoginStage.anon);

  var authStateLoading = Rx<bool>(false);

  var userLoading = Rx<bool>(false);

  Future<void> fetchUser() async {
    // TODO Подключить апи получения пользователя

    await Future.delayed(const Duration(seconds: 1));
    user.value = UserModel();
    update();
  }
}
