part of 'connection_bloc.dart';

abstract class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object?> get props => [];
}

class ChangeConnectionEvent extends ConnectionEvent {
  final ConnectivityResult connectivityResult;

  const ChangeConnectionEvent({required this.connectivityResult});

  @override
  List<Object?> get props => [connectivityResult];

}
