import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomuser/models/user/user.dart';
import 'package:randomuser/service/local_database/hive/hive_service.dart';
import 'package:randomuser/service/user/user_service.dart';
import 'package:randomuser/state_management/connection/connection_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required HiveService hiveService,
    required UserService userService,
    required this.connectionBloc,
  })  : _hiveService = hiveService,
        _userService = userService,
        super(UserLoading()) {
    connectionStatusSubscription = connectionBloc.stream.listen(
      (event) =>
          add(RefreshUserEvent(connectionResult: event.currentConnection)),
    );

    on<LoadUserEvent>(_onLoadUserEvent);
    on<RefreshUserEvent>(_onRefreshUserEvent);
  }

  final ConnectionBloc connectionBloc;
  late StreamSubscription connectionStatusSubscription;
  final HiveService _hiveService;
  final UserService _userService;

  @override
  Future<void> close() {
    connectionStatusSubscription.cancel();
    return super.close();
  }

  Future<User> getUserOnHive() async {
    User result = User.empty;
    try {
      result = await _hiveService.getUser();
      return result;
    } catch (_) {
      return result;
    }
  }

  FutureOr<void> _onLoadUserEvent(
      LoadUserEvent event, Emitter<UserState> emit) async {
    User resultValue = User.empty;

    try {
      resultValue = await _hiveService.getUser();
      if (resultValue != User.empty) {
        return emit(UserLoadedState(user: resultValue));
      }

      resultValue = await _userService.getUser();
      _hiveService.replaceUser(resultValue);
      emit(UserLoadedState(user: resultValue));
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onRefreshUserEvent(
      RefreshUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    if (event.connectionResult == ConnectivityResult.wifi) {
      await _hiveService.deleteAllUser();
    }

    User resultValue = User.empty;

    try {
      resultValue = await _hiveService.getUser();
      if (resultValue != User.empty) {
        return emit(UserLoadedState(user: resultValue));
      }

      resultValue = await _userService.getUser();
      _hiveService.replaceUser(resultValue);
      emit(UserLoadedState(user: resultValue));
    } catch (e) {
      emit(UserErrorState(errorMessage: e.toString()));
    }
  }
}
