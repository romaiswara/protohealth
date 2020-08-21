part of 'model.dart';

class User extends Equatable with SerializableMixin {
  final String id;
  final String identifier;
  final String name;
  final String email;
  final String addressDetail;
  final String addressCity;
  final double addressLatitude;
  final double addressLongitude;
  final String reminder;

  User({
    this.id,
    this.identifier,
    this.name,
    this.email,
    this.addressDetail,
    this.addressCity,
    this.addressLatitude,
    this.addressLongitude,
    this.reminder,
  });

  factory User.fromFirebaseUser({
    FirebaseUser user,
    String identifier,
    String name,
    String addressDetail,
    String addressCity,
    double latitude,
    double longitude,
    String reminder,
  }) {
    return User(
      id: user.uid,
      identifier: identifier,
      name: name,
      email: user.email,
      addressDetail: addressDetail,
      addressCity: addressCity,
      addressLatitude: latitude,
      addressLongitude: longitude,
      reminder: reminder,
    );
  }

  factory User.fromMap(Map<String, dynamic> jsonMap) {
    return User(
      id: jsonMap['id'],
      name: jsonMap['name'],
      identifier: jsonMap['identifier'],
      email: jsonMap['email'],
      addressDetail: jsonMap['detail'],
      addressCity: jsonMap['city'],
      addressLatitude: jsonMap['latitude'],
      addressLongitude: jsonMap['longitude'],
      reminder: jsonMap['reminder'],
    );
  }

  User copyWith({String reminder}) {
    return User(
      id: id,
      identifier: identifier,
      name: name,
      email: email,
      addressDetail: addressDetail,
      addressCity: addressCity,
      addressLatitude: addressLatitude,
      addressLongitude: addressLongitude,
      reminder: reminder ?? reminder,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'name': name,
      'email': email,
      'detail': addressDetail,
      'city': addressCity,
      'latitude': addressLatitude,
      'longitude': addressLongitude,
      'reminder': reminder,
    };
  }

  @override
  List<Object> get props => [
        id,
        identifier,
        name,
        email,
        addressDetail,
        addressCity,
        addressLatitude,
        addressLongitude,
        reminder,
      ];
}
