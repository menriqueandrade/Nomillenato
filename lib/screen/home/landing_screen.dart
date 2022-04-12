// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field, annotate_overrides, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roles_auth_persistencia/repositorio/auth_repositorio.dart';
import '../../bloc/auth_cubit.dart';
import '../../bloc/my_user_cubit.dart';
import '../../model/user.dart';
import '../../navegacion/routes.dart';
import '../../repositorio/implementacion/my_user_repository.dart';

class LandingScreen extends StatelessWidget {
  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => MyUserCubit(MyUserRepository())..getMyUser(),
      child: LandingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/intro_3.png',
      fit: BoxFit.fill,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Principal'),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Logout',
              onPressed: () {
                context.read<MyUserCubit>().reset();
                Navigator.pushNamed(context, Routes.home);
              }),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => context.read<AuthCubit>().signOut(),
          ),
        ],
      ),
      body: BlocBuilder<MyUserCubit, MyUserState>(
        builder: (_, state) {
          if (state is MyUserReadyState) {
            return _MyUserLandingSection(
              user: state.user,
              pickedImage: state.pickedImage,
              isSaving: state.isSaving,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _MyUserLandingSection extends StatefulWidget {
  final MyUser? user;
  final File? pickedImage;
  final bool isSaving;

  const _MyUserLandingSection(
      {Key? key, this.user, this.pickedImage, this.isSaving = false});

  @override
  _MyUserLandingState createState() => _MyUserLandingState();
}

class _MyUserLandingState extends State<_MyUserLandingSection> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _idCardController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void initState() {
    _nameController.text = widget.user?.name ?? '';
    _lastNameController.text = widget.user?.lastname ?? '';
    _ageController.text = widget.user?.age.toString() ?? '';
    _idCardController.text = widget.user?.id_card ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, current) => current is AuthSignedIn,
      builder: (_, state) {
        var _espera;
        Null test;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  runSpacing: 20,
                  children: [
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Card(
                        elevation: 25,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            debugPrint('Card tapped.');
                          },
                          child: SizedBox(

                              //197
                              //197
                              width: 500,
                              height: 200,
                              child: Center(
                                  child: Text(
                                "Hola ${_nameController.text} tu sueldo en la agrupacion acutalmente es de : 50.000",
                                style: TextStyle(fontSize: 29),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Card(
                        elevation: 25,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          // onTap: () {
                          //   debugPrint('Card tapped.');
                          // },
                          child: SingleChildScrollView(
                            child: SizedBox(
                                //197
                                //197
                                width: 500,
                                height: 300,
                                child: Text(
                                  "Historial de Pagos",
                                  style: TextStyle(fontSize: 29),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
