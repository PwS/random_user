import 'package:hive_flutter/hive_flutter.dart';
import 'package:randomuser/models/user/address/address.dart';
import 'package:randomuser/models/user/coordinates/coordinates.dart';
import 'package:randomuser/models/user/credit_card/credit_card.dart';
import 'package:randomuser/models/user/employment/employment.dart';
import 'package:randomuser/models/user/subscription/subscription.dart';
import 'package:randomuser/models/user/user.dart';

class DatabaseHive {
  DatabaseHive._();

  static Future<void> initHive() async {
    await Hive.initFlutter();
    registerAdapterHive();
  }

  static void registerAdapterHive() {
    Hive
      ..registerAdapter(UserAdapter())
      ..registerAdapter(EmploymentAdapter())
      ..registerAdapter(AddressAdapter())
      ..registerAdapter(CreditCardAdapter())
      ..registerAdapter(SubscriptionAdapter())
      ..registerAdapter(CoordinatesAdapter());
  }
}
