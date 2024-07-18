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

  factory Alamat.fromMap(Map<String, dynamic> map) {
    return Alamat(
        id: map['id'],
        namaPenerima: map['namaPenerima'],
        alamatPengiriman: map['alamatPengiriman']);
  }
}

class AlamatProvider extends ChangeNotifier {
  List<Alamat> _listAlamat = [];
  List<Alamat> get listAlamat => _listAlamat;

  AlamatProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await getAlamat();
  }

  Future<Database> initDatabase() async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'alamat_database.db'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tb_alamat(id INTEGER PRIMARY KEY, namaPenerima TEXT, alamatPengiriman TEXT)');
    }, version: 1);

    return database;
  }

  Future<void> getAlamat() async {
    final db = await initDatabase();
    final listAlamat = await db.query('tb_alamat');
    _listAlamat = listAlamat
        .map(
          (e) => Alamat.fromMap(e),
        )
        .toList();
    notifyListeners();
  }

  Future<void> insertAlamat(Alamat alamat) async {
    final db = await initDatabase();
    await db.insert('tb_alamat', alamat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await _loadData();
  }
}
