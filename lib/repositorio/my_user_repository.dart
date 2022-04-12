import 'dart:io';

import '../model/user.dart';

abstract class MyUserRepositoryBase {

  Future<MyUser?> getMyUser();
  Future<void> saveMyUser(MyUser user, File? image);
 // Future<void> landingGetUser(MyUser user, File? image);
  


}