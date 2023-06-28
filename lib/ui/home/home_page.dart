import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomuser/service/local_database/hive/hive_service.dart';
import 'package:randomuser/service/user/user_service.dart';
import 'package:randomuser/state_management/connection/connection_bloc.dart'
    as connection_bloc;
import 'package:randomuser/state_management/user/user_bloc.dart';
import 'package:randomuser/ui/custom_widget/card/custom_user_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
          hiveService: HiveService(),
          userService: UserService(),
          connectionBloc: context.read<connection_bloc.ConnectionBloc>())
        ..add(LoadUserEvent()),
      child: const Scaffold(body: _Content()),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserErrorState) {
          return Column(
            children: [
              Text('Failed Load User Caused By ${state.errorMessage}'),
              ElevatedButton(
                  onPressed: () => context.read<UserBloc>().add(
                      RefreshUserEvent(
                          connectionResult: context
                              .read<connection_bloc.ConnectionBloc>()
                              .state
                              .currentConnection)),
                  child: const Text('Refresh'))
            ],
          );
        } else if (state is UserLoadedState) {
          return Center(
            child: CustomUserCard(
                urlImage: state.user.avatar, userName: state.user.username),
          );
        } else {
          return const Center(
              child: Text('Something Went Wrong Outside The State'));
        }
      },
    );
  }
}
