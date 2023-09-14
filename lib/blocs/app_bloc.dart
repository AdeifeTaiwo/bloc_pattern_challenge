

import 'package:bloc_pattern_challenge/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_events.dart';
import 'app_state.dart';


//Bloc takes event class and state class,
//userRepository will be passed from the ui

//super(UserLoadingState) because

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()){

    on<UserLoadEvent>((event, emit) async{
      emit(UserLoadingState());

      try{
        final user = await _userRepository.getUsers();
         emit(UserLoadedState(user));
      }

      catch(e){
        emit(UserErrorState(e.toString()??"Error occurred"));
      }

    });
  }




}