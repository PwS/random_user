import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'subscription.g.dart';

@HiveType(typeId: 5)
class Subscription extends Equatable {
  @HiveField(0)
  final String? plan;
  @HiveField(1)
  final String? status;
  @HiveField(2)
  final String? paymentMethod;
  @HiveField(3)
  final String? term;

  const Subscription({this.plan, this.status, this.paymentMethod, this.term});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      plan: json['plan'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      term: json['term'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan'] = plan;
    data['status'] = status;
    data['payment_method'] = paymentMethod;
    data['term'] = term;
    return data;
  }

  @override
  List<Object?> get props => [plan, status, paymentMethod, term];
}
