import 'dart:developer';
import 'package:explore_uganda/models/auth/chatMessageModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = '${getDirectory.path}/exploreug.db';
    log(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE Message (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          message_number TEXT NOT NULL,
          isSender BOOLEAN NOT NULL,
          text TEXT,
          imageList TEXT, -- Store image URLs as a comma-separated string
          isSeen BOOLEAN NOT NULL DEFAULT 0,
          timestamp INTEGER NOT NULL,
          delivered BOOLEAN NOT NULL
        )
      ''');

    log('TABLE CREATED');
  }

  Future<List<ChatMessage>> getMessage() async {
    final db = await _databaseService.database;
    var data = await db.rawQuery('SELECT * FROM Message');
    List<ChatMessage> message = List.generate(
        data.length, (index) => ChatMessage.fromJson(data[index]));
    print(message.length);
    return message;
  }

  Future<void> insertMessage(ChatMessage message) async {
    final db = await _databaseService.database;
    var data = await db.rawInsert(
        'INSERT INTO Message(message_number, isSender, text, imageList, isSeen,timestamp, delivered) VALUES(?,?,?,?,?,?,?)',
        [message.message_number, message.isSender, message.text, message.imagesList.toString(), message.isSeen, message.timestamp, message.delivered]);
    log('inserted $data');
  }

  // Future<void> editMessage(ChatMessage message) async {
  //   final db = await _databaseService.database;
  //   var data = await db.rawUpdate(
  //       'UPDATE Message SET title=?,language=?,year=? WHERE ID=?',
  //       [message.title, message.language, message.year, message.id]);
  //   log('updated $data');
  // }

  Future<void> deleteMessage(String id) async {
    final db = await _databaseService.database;
    var data = await db.rawDelete('DELETE from Message WHERE id=?', [id]);
    log('deleted $data');
  }
}
