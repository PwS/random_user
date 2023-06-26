import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomuser/service/connection/connection_service.dart';

part 'connection_event.dart';

part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  ConnectionBloc({required ConnectionService connectionService})
      : _connectionService = connectionService,
        super(const ConnectionState()) {
    connectionSubscription = _connectionService.listenGetStatus().listen(
        (event) => add(ChangeConnectionEvent(connectivityResult: event)));

    on<ChangeConnectionEvent>(_onChangeConnectionEvent);
  }

  final ConnectionService _connectionService;
  late StreamSubscription connectionSubscription;

  FutureOr<void> _onChangeConnectionEvent(
      ChangeConnectionEvent event, Emitter<ConnectionState> emit) async {
    emit(ConnectionState(currentConnection: event.connectivityResult));
  }


  @override
  Future<void> close() {
    connectionSubscription.cancel();
    return super.close();
  }

}
