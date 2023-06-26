import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:randomuser/models/user/address/address.dart';
import 'package:randomuser/models/user/credit_card/credit_card.dart';
import 'package:randomuser/models/user/employment/employment.dart';
import 'package:randomuser/models/user/subscription/subscription.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? uid;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String? firstName;
  @HiveField(4)
  final String? lastName;
  @HiveField(5)
  final String? username;
  @HiveField(6)
  final String? email;
  @HiveField(7)
  final String? avatar;
  @HiveField(8)
  final String? gender;
  @HiveField(9)
  final String? phoneNumber;
  @HiveField(10)
  final String? socialInsuranceNumber;
  @HiveField(11)
  final String? dateOfBirth;
  @HiveField(12)
  final Employment? employment;
  @HiveField(13)
  final Address? address;
  @HiveField(14)
  final CreditCard? creditCard;
  @HiveField(15)
  final Subscription? subscription;

  const User(
      {this.id,
      this.uid,
      this.password,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.avatar,
      this.gender,
      this.phoneNumber,
      this.socialInsuranceNumber,
      this.dateOfBirth,
      this.employment,
      this.address,
      this.creditCard,
      this.subscription});

  static const empty = User();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'avatar': avatar,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'socialInsuranceNumber': socialInsuranceNumber,
      'dateOfBirth': dateOfBirth,
      'employment': employment,
      'address': address,
      'creditCard': creditCard,
      'subscription': subscription,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      uid: json['uid'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      socialInsuranceNumber: json['socialInsuranceNumber'],
      dateOfBirth: json['dateOfBirth'],
      employment: json['employment'] == null
          ? null
          : Employment.fromJson(json['employment']),
      address:
          json['address'] == null ? null : Address.fromJson(json['address']),
      creditCard: json['creditCard'] == null
          ? null
          : CreditCard.fromJson(json['creditCard']),
      subscription: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        password,
        firstName,
        lastName,
        username,
        email,
        avatar,
        gender,
        phoneNumber,
        socialInsuranceNumber,
        dateOfBirth,
        employment,
        address,
        creditCard,
        subscription
      ];
}
