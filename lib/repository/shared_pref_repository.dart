part of 'repository.dart';

class SharedPreferencesRepository<M extends SerializableMixin> {
  final Logger logger = Logger('SharedPreferences');
  final String key;
  final M Function(Map<String, dynamic> jsonMap) factory;

  SharedPreferencesRepository({
    @required this.key,
    @required this.factory,
  });

  Future<M> loadLocal() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey(key)) {
      logger.fine('load local available ${M.toString()}');
      final String jsonString = sp.getString(key);
      return factory(json.decode(jsonString));
    }
    logger.fine('load local not found ${M.toString()}');
    return null;
  }

  Future<bool> saveLocal(M model) async {
    logger.fine('save local ${M.toString()}');
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool result = await sp.setString(
      key,
      json.encode(
        model.toJson(),
      ),
    );
    return result;
  }

  Future<bool> clearLocal() async {
    logger.fine('clear local ${M.toString()}');
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool result = await sp.remove(key);
    return result;
  }
}
