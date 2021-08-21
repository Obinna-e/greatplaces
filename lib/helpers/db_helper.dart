import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

/* Can't just openDatabase with dbPath because dbPath is just the folder
where database is stored. Have to use path.join() because you need dbPath 
that includes database name*/
class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT');
      },
      /*On first launch this path doesn't exist. Function actually creates this 
      path when it doesn't exist*/
      version: 1, //can change version if want to work with new db
    );
  }
}
