import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'Note.dart';
//untuk menentukan letak pathnya / databasenya dimana
import 'package:path/path.dart';

///deklarasi kelas DBHelper, yang akan digunakan untuk berinteraksi dengan database
class DBHelper {
  ///variabel instance dari kelas Database yang digunakan untuk berinteraksi dengan database SQLite
  Database? _database;

  ///metode yang digunakan untuk mendapatkan instance database
  Future<Database?> get dbInstance async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  ///metode asinkron yang digunakan untuk menginisialisasi database
  initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notesdb.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT)");
      },
    );
  }

  //Membuat fungsi getNotes / mengambil notes ketika akan dijalankan dari table
  Future<List<Note>> getNotes() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db!.query('notes');
    return List.generate(
      maps.length,
      (i) {
        return Note(title: maps[i]['title'], body: maps[i]['body']);
      },
    );
  }

  ///metode asinkron yang digunakan untuk menyimpan catatan baru ke database. Ini akan memasukkan catatan ke dalam tabel "notes" dengan menggunakan metode insert
  Future<void> saveNote(Note note) async {
    final db = await dbInstance;
    await db!.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
