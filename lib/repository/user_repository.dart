part of 'repository.dart';

class UserRepository extends SharedPreferencesRepository<User> {
  static const String userPrefKey = 'user';

  UserRepository()
      : super(
            key: userPrefKey,
            factory: (Map<String, dynamic> jsonMap) {
              return User.fromMap(jsonMap);
            });
}
