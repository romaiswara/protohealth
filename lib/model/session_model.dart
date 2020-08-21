part of 'model.dart';

class Session extends Equatable with SerializableMixin {
  final String identifier;
  final String userId;
  final String langguageCode;

  Session({
    this.identifier,
    this.userId,
    this.langguageCode,
  });

  Session copyWith({
    String identifier,
    String userId,
    String languageCode,
  }) {
    return Session(
      identifier: identifier ?? this.identifier,
      userId: userId ?? this.userId,
      langguageCode: languageCode ?? this.langguageCode,
    );
  }

  factory Session.fromMap(Map<String, dynamic> jsonMap) {
    return Session(
      identifier: jsonMap['identifier'],
      userId: jsonMap['user_id'],
      langguageCode: jsonMap['language_code'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'user_id': userId,
      'language_code': langguageCode,
    };
  }

  @override
  List<Object> get props => [
        identifier,
        userId,
        langguageCode,
      ];

  @override
  String toString() {
    return 'Session{identifier: $identifier, userId: $userId, langguage_code: $langguageCode}';
  }
}
