import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'credit_card.g.dart';


@HiveType(typeId: 3)
class CreditCard extends Equatable {
  @HiveField(0)
  final String? ccNumber;

  const CreditCard({this.ccNumber});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(ccNumber: json['cc_number']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cc_number'] = ccNumber;
    return data;
  }

  @override
  List<Object?> get props => [ccNumber];
}
