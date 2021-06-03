import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final userUid = ''.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userProfileUrl = ''.obs;
  static AuthController get to => Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  setUserUID({@required String userId}) => userUid(userId.toString());
  setUserName({@required String name}) => userName(name);
  setUserEmail({@required String email}) => userEmail(email);
  setUserProfileUrl({@required String profileUrl}) =>
      userProfileUrl(profileUrl);
}
