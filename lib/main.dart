import 'dart:async' as lib_async;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomuser/db/db_hive/database_hive.dart';
import 'package:randomuser/service/connection/connection_service.dart';
import 'package:randomuser/state_management/connection/connection_bloc.dart'
    as connection_bloc;
import 'package:randomuser/ui/home/home_page.dart';
import 'package:randomuser/utils/bloc_observer.dart';

void main() {
  ///BlocObserver
  Bloc.observer = AppBlocObserver();

  ///Zoned Errors
  lib_async.runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      ///Init Hive
      await DatabaseHive.initHive();

      /// Lock device orientation to portrait & Default StatusBar Colors
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.lightBlueAccent));
      SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      ).then((_) {
        runApp(const MyApp());
      });
    },
    (error, stackTrace) async {},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ConnectionService(connectivity: Connectivity()),
      child: BlocProvider<connection_bloc.ConnectionBloc>(
        create: (context) => connection_bloc.ConnectionBloc(
            connectionService: context.read<ConnectionService>()),
        child: MaterialApp(
          title: 'Listen To Connection',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Builder(builder: (context) {
            return BlocListener<connection_bloc.ConnectionBloc,
                connection_bloc.ConnectionState>(
              listener: (context, state) {
                if (state.currentConnection == ConnectivityResult.mobile) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Connect To Mobile')),
                    );
                } else if (state.currentConnection == ConnectivityResult.wifi) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Connect To Wifi')),
                    );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          content: Text(
                              'Current Connection Is ${state.currentConnection}')),
                    );
                }
              },
              child: const HomePage(),
            );
          }),
        ),
      ),
    );
  }
}
