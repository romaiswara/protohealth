part of 'service.dart';

class UserService {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _userCollection.document(user.id).setData(user.toJson());
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();
    if (snapshot.exists) {
      return User.fromMap(snapshot.data);
    }
    return null;
  }
}
