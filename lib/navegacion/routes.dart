
import 'package:flutter/material.dart';
import 'package:roles_auth_persistencia/screen/home/home_screen.dart';
import 'package:roles_auth_persistencia/screen/home/landing_screen.dart';
import 'package:roles_auth_persistencia/screen/intro/intro_screen.dart';
import 'package:roles_auth_persistencia/screen/intro/splash_screen.dart';

import '../screen/intro/email_create_screen.dart';
import '../screen/intro/email_signin_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';
  static const landing = '/landing';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      case createAccount:
      return _buildRoute(EmailCreate.create);
      case signInEmail:
      return _buildRoute(EmailSignIn.create);
      case landing:
      return _buildRoute(LandingScreen.create);
      default:
        throw Exception("Las Rutas no Existen");
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
