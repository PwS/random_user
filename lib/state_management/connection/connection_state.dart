part of 'connection_bloc.dart';

class ConnectionState extends Equatable {
  final ConnectivityResult currentConnection;

  const ConnectionState({this.currentConnection = ConnectivityResult.none});

  ConnectionState copyWith({
    ConnectivityResult? currentConnection,
  }) {
    return ConnectionState(
      currentConnection: currentConnection ?? this.currentConnection,
    );
  }

  @override
  List<Object?> get props => [currentConnection];
}
