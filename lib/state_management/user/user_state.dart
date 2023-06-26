part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserErrorState extends UserState {
  final String errorMessage;

  const UserErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}

class UserLoadedState extends UserState {
  final User user;

  const UserLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}
