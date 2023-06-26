import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'coordinates.g.dart';

@HiveType(typeId: 6)
class Coordinates extends Equatable {
  @HiveField(0)
  final double? lat;
  @HiveField(1)
  final double? lng;

  const Coordinates({this.lat, this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(lat: json['lat'], lng: json['lng']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  List<Object?> get props => [lat, lng];
}
