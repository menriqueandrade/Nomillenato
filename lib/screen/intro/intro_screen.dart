// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_element, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:roles_auth_persistencia/bloc/auth_cubit.dart';

import '../../navegacion/routes.dart';

class IntroScreen extends StatelessWidget {
  static Widget create(BuildContext context) => IntroScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenidos"),
      ),
      body: _IntroPagina(),
    );
  }
}

class _IntroPagina extends HookWidget {
  final String ejemploTexto =
      "Lorem ,asdadadadahsdba dabdasndaj dash dajdh ajahj as djasdasjdasjasj dasasasasd as as das asd as as asa ad dad ads";
  
  @override
  Widget build(BuildContext context) {
    final estaIniciandosesion = context.watch<AuthCubit>().state is AuthSigningIn;
    return AbsorbPointer(
      // Para cuando se este iniciando no se pudeda dar click en ningun lado
      absorbing: estaIniciandosesion,
      child: PageIndicatorContainer(
        child: PageView(
          children: [
            _DescripcionPagina(
              text: ejemploTexto,
              imagePath: "assets/intro_1.png",
            ),
            _DescripcionPagina(
              text: ejemploTexto,
              imagePath: "assets/intro_2.png",
            ),
            _DescripcionPagina(
              text: ejemploTexto,
              imagePath: "assets/intro_3.png",
            ),
            _LoginPagina(),
          ],
        ),
        length: 4,
      ),
    );
  }
}

class _DescripcionPagina extends StatelessWidget {
  final String text;

  final String imagePath;

  const _DescripcionPagina(
      {Key? key, required this.text, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class _LoginPagina extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
  
    final estaIniciandosesion = context.watch<AuthCubit>().state is AuthSigningIn;
    return Container(
      padding: EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/intro_1.png',
              width: 200,
              height: 200,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Ingresa o Registrate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
           
            if (estaIniciandosesion) CircularProgressIndicator(),
            SizedBox(height: 5,),
             _LoginButton(
              text: "Iniciar Sesion Correo",
              imagePatch: "assets/logo_correo.png",
              color: Color.fromARGB(255, 205, 53, 42),
              textColor: Color.fromARGB(255, 0, 0, 0),
              onTap: () {
                context.read<AuthCubit>().reset();
                Navigator.pushNamed(context, Routes.signInEmail);
              },
            ),
            
            SizedBox(
              height: 8,
            ),
            _LoginButton(
              text: "Iniciar Sesion Anonimo",
              imagePatch: "assets/logo_anonimo.png",
              color: Color.fromARGB(255, 189, 181, 181),
              textColor: Color.fromARGB(255, 0, 0, 0),
              onTap: ()=> context.read<AuthCubit>().signInAnonymously(),
            ),
            SizedBox(
              height: 8,
            ),
            _LoginButton(
              text: "Iniciar Sesion Con Facebook",
              imagePatch: "assets/logo_facebook.png",
              color: Color.fromARGB(255, 0, 140, 255),
              textColor: Color.fromARGB(255, 249, 249, 249),
              onTap: () {},
            ),
      
            SizedBox(
              height: 8,
            ),
            _LoginButton(
              text: "Iniciar Sesion Con Google",
              imagePatch: "assets/logo_google.png",
              color: Color.fromARGB(255, 255, 255, 255),
              textColor: Color.fromARGB(255, 140, 129, 129),
              onTap: () => context.read<AuthCubit>().signInWithGoogle(),
            ),
           
            SizedBox(
              height: 5,
            ),
            // ignore: deprecated_member_use
            OutlinedButton(
              onPressed: () {
                   context.read<AuthCubit>().reset();
                    Navigator.pushNamed(context, Routes.createAccount);
              },
              child: Text("Crear cuenta"),
            )
          
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final String imagePatch;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  const _LoginButton(
      {Key? key,
      required this.text,
      required this.imagePatch,
      this.color = Colors.white,
      this.textColor = Colors.black,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(
                imagePatch,
                width: 30,
                height: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
