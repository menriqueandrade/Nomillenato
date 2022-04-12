import 'dart:io';


import 'package:roles_auth_persistencia/model/user.dart';

import '../../provider/firebase_provider.dart';
import '../my_user_repository.dart';



 class  MyUserRepository extends MyUserRepositoryBase{
   final provider = FirebaseProvider();
  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user, File? image)=> provider.saveMyUser(user, image);

  
  // @override
  // Future<void> landingGetUser(MyUser user, File? image)=> provider.saveMyUser(user, image);

  


}