part of 'core.dart';

class App {
  // Global variable for session
  Session session;

  // Global variabel for user
  User user;

  // Global variable for last location user detect
  LatLng lastLocation;

  // Global variable for firebase token
  String firebaseToken;

  static App get main => GetIt.instance.get<App>();
}
