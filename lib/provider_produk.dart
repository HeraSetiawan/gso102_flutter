import 'dart:convert';
import 'package:myapp/produk_modal.dart';
import 'package:myapp/store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProduk extends ChangeNotifier {
  List<ProdukModal> _listProduk = [];
  List<ProdukModal> get listProduk => _listProduk;
  int get jmlKeranjang => _listProduk.length;

  ProviderProduk() {
    _getListProduk();
  }

  void tambahKeranjang(ProdukModal produk) {
    _listProduk.add(produk);
    _setListProduk();
    notifyListeners();
  }

  void hapusKeranjang(ProdukModal produk) {
    _listProduk.remove(produk);
    _setListProduk();
    notifyListeners();
  }

  Future<void> _setListProduk() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listJson = _listProduk
        .map(
          (produk) => jsonEncode(produk.toJson()),
        )
        .toList();
    prefs.setStringList('listProduk', listJson);
  }

  Future<void> _getListProduk() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? listJson = prefs.getStringList('listProduk');
    if (listJson != null) {
      _listProduk.clear();
      _listProduk = listJson
          .map(
            (json) => ProdukModal.fromJson(jsonDecode(json)),
          )
          .toList();
      notifyListeners();
    }
  }

  String hitungTotal() {
    num totalHarga = 0;
    for (var produk in _listProduk) {
      totalHarga += produk.harga;
    }
    return formatRupiah(totalHarga);
  }
}
