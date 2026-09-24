import 'package:flutter_test/flutter_test.dart';
import 'package:randomuser/models/user/user.dart';

///Shape of a response from https://random-data-api.com/api/v2/users
const Map<String, dynamic> apiResponse = {
  'id': 42,
  'uid': 'abc-123',
  'password': 'secret',
  'first_name': 'Jane',
  'last_name': 'Doe',
  'username': 'jane.doe',
  'email': 'jane.doe@email.com',
  'avatar': 'https://robohash.org/jane.png',
  'gender': 'Female',
  'phone_number': '+1 555 0100',
  'social_insurance_number': '123456789',
  'date_of_birth': '1990-01-01',
  'employment': {'title': 'Engineer', 'key_skill': 'Flutter'},
  'address': {
    'city': 'Springfield',
    'street_name': 'Main Street',
    'street_address': '742 Main Street',
    'zip_code': '12345',
    'state': 'Oregon',
    'country': 'United States',
    'coordinates': {'lat': 44.05, 'lng': -123.09},
  },
  'credit_card': {'cc_number': '4111-1111-1111-1111'},
  'subscription': {
    'plan': 'Gold',
    'status': 'Active',
    'payment_method': 'Credit card',
    'term': 'Monthly',
  },
};

void main() {
  group('User.fromJson', () {
    test('reads every field from the API response', () {
      final user = User.fromJson(apiResponse);

      expect(user.id, 42);
      expect(user.username, 'jane.doe');
      expect(user.avatar, 'https://robohash.org/jane.png');
      expect(user.firstName, 'Jane');
      expect(user.lastName, 'Doe');
      expect(user.phoneNumber, '+1 555 0100');
      expect(user.socialInsuranceNumber, '123456789');
      expect(user.dateOfBirth, '1990-01-01');
      expect(user.employment?.keySkill, 'Flutter');
      expect(user.address?.coordinates?.lat, 44.05);
      expect(user.creditCard?.ccNumber, '4111-1111-1111-1111');
      expect(user.subscription?.paymentMethod, 'Credit card');
    });

    test('leaves nested objects null when they are missing', () {
      final user = User.fromJson(const {'id': 1, 'username': 'solo'});

      expect(user.username, 'solo');
      expect(user.employment, isNull);
      expect(user.address, isNull);
      expect(user.creditCard, isNull);
      expect(user.subscription, isNull);
    });
  });

  test('toJson produces JSON that fromJson reads back to the same user', () {
    final user = User.fromJson(apiResponse);

    expect(User.fromJson(user.toJson()), user);
  });
}
