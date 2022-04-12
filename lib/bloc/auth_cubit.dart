// ignore_for_file: unused_field, unused_element, prefer_const_constructors

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roles_auth_persistencia/repositorio/auth_repositorio.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepositoryBase _authRepository;
  late StreamSubscription _authSubscription;
  AuthCubit(this._authRepository) : super(AuthInitialState());

  Future<void> init() async{
    await Future.delayed(Duration(seconds: 3));
    _authSubscription = _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  Future<void> reset() async=> emit(AuthInitialState());

  void _authStateChanged(AuthUser? user) =>user==null? emit(AuthSignedOut()): emit(AuthSignedIn(user));
  
  //cubit escuchando a anonimo
  Future<void> signInAnonymously() => _signIn(_authRepository.signInAnonymously());
  
  //cubit escuchando a inicio Google
  Future<void> signInWithGoogle() => _signIn(_authRepository.signInWithGoogle());
  Future<void> createUserWithEmailAndPassword(String email, String password) => _signIn(_authRepository.createUserWithEmailAndPassword(email,password));
  Future<void> signInUserWithEmailAndPassword(String email, String password) => _signIn(_authRepository.signInWithEmailAndPassword(email,password));
  
  Future<void> _signIn(Future<AuthUser?> auxUser) async{

    try {
      emit(AuthSigningIn());
      final user = await auxUser;
      if(user == null){
        emit(AuthError("Error desconocido intenta de nuevo"));

      }else{
        emit(AuthSignedIn(user));
      }
      
    } catch (e) {
      emit(AuthError('Error: ${e.toString()}'));
    }
  }

Future<void> signOut() async{
await _authRepository.signOut();
emit(AuthSignedOut());

}

@override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

}
abstract class AuthState extends Equatable{
  List<Object?> get props => [];

}
class AuthInitialState extends AuthState{


}
class AuthSignedOut extends AuthState{


}
class AuthSigningIn extends AuthState{


}
class AuthError extends AuthState{

  final String message;

  AuthError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class AuthSignedIn extends AuthState{
  /*Para iniciar Sesion*/
final AuthUser user;

AuthSignedIn(this.user);

@override
List<Object?> get props => [user];
}
