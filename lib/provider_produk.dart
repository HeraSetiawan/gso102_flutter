import 'package:myapp/produk_modal.dart';
import 'package:flutter/material.dart';

class ProviderProduk extends ChangeNotifier {
  final List<ProdukModal> _listProduk = [];
  List<ProdukModal> get listProduk => _listProduk;
  int get jmlKeranjang => _listProduk.length;

  void tambahKeranjang(ProdukModal produk) {
    _listProduk.add(produk);
    notifyListeners();
  }

  void hapusKeranjang(ProdukModal produk) {
    _listProduk.remove(produk);
    notifyListeners();
  }
}