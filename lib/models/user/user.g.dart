// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      uid: fields[1] as String?,
      password: fields[2] as String?,
      firstName: fields[3] as String?,
      lastName: fields[4] as String?,
      username: fields[5] as String?,
      email: fields[6] as String?,
      avatar: fields[7] as String?,
      gender: fields[8] as String?,
      phoneNumber: fields[9] as String?,
      socialInsuranceNumber: fields[10] as String?,
      dateOfBirth: fields[11] as String?,
      employment: fields[12] as Employment?,
      address: fields[13] as Address?,
      creditCard: fields[14] as CreditCard?,
      subscription: fields[15] as Subscription?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.username)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.avatar)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.phoneNumber)
      ..writeByte(10)
      ..write(obj.socialInsuranceNumber)
      ..writeByte(11)
      ..write(obj.dateOfBirth)
      ..writeByte(12)
      ..write(obj.employment)
      ..writeByte(13)
      ..write(obj.address)
      ..writeByte(14)
      ..write(obj.creditCard)
      ..writeByte(15)
      ..write(obj.subscription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
