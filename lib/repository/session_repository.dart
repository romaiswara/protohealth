part of 'repository.dart';

class SessionRepository extends SharedPreferencesRepository<Session> {
  static const String sessionPrefKey = 'session';

  SessionRepository() : super(
      key: sessionPrefKey,
      factory: (Map<String, dynamic> jsonMap) {
        return Session.fromMap(jsonMap);
      });
}