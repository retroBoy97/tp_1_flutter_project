import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  static const String _databaseName = 'FDTP.db';
  static const int _databaseVersion = 1;

  static const String tableBook = 'book';
  static const String tableUser = 'user';

  // Singleton pattern
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);

    // Pour réinitialiser la base de données
    // await deleteDatabase(path);

    // Ouvrir/créer la base de données
    Database database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );

    print("Database opened successfully at: $path");
    return database;
  }

  /// Créer les tables lors de la première initialisation
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableBook (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        image TEXT NOT NULL,
        user_email TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableUser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        fullName TEXT NOT NULL
      )
    ''');

    print("Tables created successfully!");
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      print("Database closed");
    }
  }

  Future<void> deleteDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);
    await deleteDatabase(path);
    _database = null;
    print("Database deleted");
  }
}
