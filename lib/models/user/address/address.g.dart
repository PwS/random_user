// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 2;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      city: fields[0] as String?,
      streetName: fields[1] as String?,
      streetAddress: fields[2] as String?,
      zipCode: fields[3] as String?,
      state: fields[4] as String?,
      country: fields[5] as String?,
      coordinates: fields[6] as Coordinates?,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.streetName)
      ..writeByte(2)
      ..write(obj.streetAddress)
      ..writeByte(3)
      ..write(obj.zipCode)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
