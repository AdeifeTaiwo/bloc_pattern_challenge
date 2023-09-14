import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';


//To create state, create an abstract class,
//in block you have to create class for each state

// Equatable is used to compare two values, if 2 variables are
//equal we're not going to trigger the UI, or draw

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}


class UserErrorState extends UserState {
  final String errorMessage;
  UserErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
