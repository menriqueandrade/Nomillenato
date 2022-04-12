// ignore_for_file: unused_element, unused_field, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:roles_auth_persistencia/repositorio/auth_repositorio.dart';

class AuthRepository extends AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;
  AuthUser? _userFromFirebase(User? user) =>
      user == null ? null : AuthUser(user.uid, user.email);

  @override
  // TODO: implement onAuthStateChanged
  Stream<AuthUser?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> signInAnonymously() async {
    final user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user.user);
  }

  @override
  Future<void> signOut() async {
  

    await _firebaseAuth.signOut();
    //await GoogleSignOut().signOut();
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) async {
   final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
   return _userFromFirebase(result.user);
  }

  @override
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async{
    final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
   return _userFromFirebase(result.user);
  }

  
 

}
