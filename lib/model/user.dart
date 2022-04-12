// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String name;
  final String lastname;
  final int age;
  final String id_card;
  final String? image;

   MyUser(this.id, this.name, this.lastname, this.age, this.id_card, {this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastname': lastname,
      'age': age,
      'id_card': id_card,
      'image': newImage ?? image,
    };
  }


  MyUser.fromFirebaseMap(Map<String, Object?> data):
  id = data['id'] as String,
  name = data['name'] as String,
  lastname = data['lastname'] as String,
  id_card = data['id_card'] as String,
  age = data['age'] as int,
  image = data['image'] as String?;
}
