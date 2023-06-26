import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:randomuser/models/user/coordinates/coordinates.dart';

part 'address.g.dart';


@HiveType(typeId: 2)
class Address extends Equatable {
  @HiveField(0)
  final String? city;
  @HiveField(1)
  final String? streetName;
  @HiveField(2)
  final String? streetAddress;
  @HiveField(3)
  final String? zipCode;
  @HiveField(4)
  final String? state;
  @HiveField(5)
  final String? country;
  @HiveField(6)
  final Coordinates? coordinates;

  const Address(
      {this.city,
      this.streetName,
      this.streetAddress,
      this.zipCode,
      this.state,
      this.country,
      this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        city: json['city'],
        streetName: json['street_name'],
        streetAddress: json['street_address'],
        zipCode: json['zip_code'],
        state: json['state'],
        country: json['country'],
        coordinates: json['coordinates'] != null
            ? Coordinates.fromJson(json['coordinates'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['street_name'] = streetName;
    data['street_address'] = streetAddress;
    data['zip_code'] = zipCode;
    data['state'] = state;
    data['country'] = country;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props =>
      [city, streetName, streetAddress, zipCode, state, country, coordinates];
}
