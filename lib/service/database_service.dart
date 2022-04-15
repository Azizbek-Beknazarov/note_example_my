import 'package:note_example_my/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider.init();
  static Database? _database;

  DatabaseProvider.init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initilizeDB('notesdb.db');
    return _database!;
  }

  Future<Database> _initilizeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $TABLE_NAME (
  ${NoteField.id} $idType,
  ${NoteField.title} $textType,
  ${NoteField.description} $textType,
  ${NoteField.createdAt} $textType)''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<NoteModel> create(NoteModel note) async {
    final db = await instance.database;
    final id = await db.insert(TABLE_NAME, note.toMap());
    return note.copy(id: id);
  }

  Future<NoteModel> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(TABLE_NAME,
        columns: NoteField.values,
        where: '${NoteField.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return NoteModel.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found /////');
    }
  }

  Future<List<NoteModel>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NoteField.createdAt} ASC';
    final result = await db.query(TABLE_NAME, orderBy: orderBy);
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> update(NoteModel note) async {
    final db = await instance.database;
    return db.update(TABLE_NAME, note.toMap(),
        where: '${NoteField.id} = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(TABLE_NAME, where: '${NoteField.id} = ?', whereArgs: [id]);
  }
}
