import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Alamat {
  final int? id;
  final String namaPenerima;
  final String alamatPengiriman;

  Alamat({this.id, required this.namaPenerima, required this.alamatPengiriman});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'namaPenerima': namaPenerima,
      'alamatPengiriman': alamatPengiriman,
    };
  }
}

class AlamatProvider extends ChangeNotifier {
  List<Alamat> _listProduk = [];
  List<Alamat> get listProduk => _listProduk;

  Future<Database> initDatabase() async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'alamat_database.db'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tb_alamat(id INTEGER PRIMARY KEY, namaPenerima TEXT, alamatPengiriman TEXT)');
    }, version: 1);

    return database;
  }

  Future<void> insertAlamat(Alamat alamat) async {
    final db = await initDatabase();
    await db.insert('alamat', alamat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
