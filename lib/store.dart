import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.store),
        title: Text("Toko WakEbok"),
      ),
    );
  }
}

Future<List> ambilProduk() async {
final respon = await http.get(Uri.parse("https://fakestoreapi.com/products"));
if (respon.statusCode == 200) {
  final data = jsonDecode(respon.body); 
  return data;
}
throw Exception('Gagal Memuat Data');
}