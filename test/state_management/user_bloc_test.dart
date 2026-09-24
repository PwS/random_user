import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:randomuser/models/user/user.dart';
import 'package:randomuser/state_management/connection/connection_bloc.dart';
import 'package:randomuser/state_management/user/user_bloc.dart';

import '../helpers/fakes.dart';

void main() {
  const cachedUser = User(id: 1, username: 'cached.user');
  const apiUser = User(id: 2, username: 'api.user');

  late FakeHiveService hiveService;
  late FakeUserService userService;
  late FakeConnectionService connectionService;
  late ConnectionBloc connectionBloc;
  late UserBloc userBloc;

  void createBlocs({User cached = User.empty}) {
    hiveService = FakeHiveService(cached);
    userService = FakeUserService(apiUser);
    connectionService = FakeConnectionService();
    connectionBloc = ConnectionBloc(connectionService: connectionService);
    userBloc = UserBloc(
      hiveService: hiveService,
      userService: userService,
      connectionBloc: connectionBloc,
    );
  }

  tearDown(() async {
    await userBloc.close();
    await connectionBloc.close();
    await connectionService.controller.close();
  });

  group('LoadUserEvent', () {
    test('shows the cached user without calling the API', () async {
      createBlocs(cached: cachedUser);

      userBloc.add(LoadUserEvent());

      await expectLater(
        userBloc.stream,
        emits(const UserLoadedState(user: cachedUser)),
      );
      expect(userService.callCount, 0);
    });

    test('shows "No Internet" when the cache is empty and offline', () async {
      createBlocs();

      userBloc.add(LoadUserEvent());

      await expectLater(
        userBloc.stream,
        emits(const UserErrorState(errorMessage: 'No Internet')),
      );
      expect(userService.callCount, 0);
    });
  });

  group('connection changes', () {
    test('on Wi-Fi, clears the cache and fetches a new user', () async {
      createBlocs(cached: cachedUser);

      connectionService.controller.add(ConnectivityResult.wifi);

      await expectLater(
        userBloc.stream,
        emitsInOrder([
          UserLoading(),
          const UserLoadedState(user: apiUser),
        ]),
      );
      expect(hiveService.deleteCount, 1);
      expect(userService.callCount, 1);
      expect(hiveService.cachedUser, apiUser);
    });

    test('on mobile data, keeps the cached user', () async {
      createBlocs(cached: cachedUser);

      connectionService.controller.add(ConnectivityResult.mobile);

      await expectLater(
        userBloc.stream,
        emitsInOrder([
          UserLoading(),
          const UserLoadedState(user: cachedUser),
        ]),
      );
      expect(hiveService.deleteCount, 0);
      expect(userService.callCount, 0);
    });
  });
}
