part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {}

class RefreshUserEvent extends UserEvent {
  final ConnectivityResult connectionResult;

  const RefreshUserEvent({required this.connectionResult});

  @override
  List<Object> get props => [connectionResult];
}
