import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String _settings = 'Settings';

Future<void> initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox(_settings);
}

class HiveX {
  static Box<dynamic> getSettingBox() => Hive.box(_settings);

  static String get userID => getSettingBox().get('id');
  static setUserId(userID) => getSettingBox().put('id', userID);
}
