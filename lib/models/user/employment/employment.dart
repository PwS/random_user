import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'employment.g.dart';

@HiveType(typeId: 1)
class Employment extends Equatable {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? keySkill;

  const Employment({this.title, this.keySkill});

  factory Employment.fromJson(Map<String, dynamic> json) {
    return Employment(title: json['title'], keySkill: json['key_skill']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['key_skill'] = keySkill;
    return data;
  }

  @override
  List<Object?> get props => [title, keySkill];
}
