// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_cubit.dart';


class EmailCreate extends StatefulWidget {
  static Widget create(BuildContext context) => EmailCreate();

  @override
  _EmailCreateState createState() => _EmailCreateState();
}

class _EmailCreateState extends State<EmailCreate> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'Los campos estan vacios' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Los campos estan vacios';
    if (value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
    if (_passwordController.text != _repeatPasswordController.text) return 'Las contraseñas no coiciden';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Crear Cuenta')),
        body: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (_, state) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_const_constructors
                      if (state is AuthSigningIn) Center(child: CircularProgressIndicator()),
                      if (state is AuthError)
                        Text(
                          state.message,
                          style: TextStyle(color: Colors.red, fontSize: 24),
                        ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Correo'),
                        validator: emailValidator,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Contraseña'),
                        validator: passwordValidator,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _repeatPasswordController,
                        decoration: InputDecoration(labelText: 'Repetir contraseña'),
                        validator: passwordValidator,
                      ),
                      Center(
                        child: ElevatedButton(
                          child: const Text('Crear'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              context.read<AuthCubit>().createUserWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}