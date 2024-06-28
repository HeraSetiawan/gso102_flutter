import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/detail_product.dart';

class MyStore extends StatefulWidget {
  const MyStore({super.key});

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  late Future<List<ProdukModal>> _futureProduk;
  @override
  void initState() {
    _futureProduk = ambilProduk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.store),
        title: const Text("Toko WakEbok"),
      ),
      body: FutureBuilder<List<ProdukModal>>(
        future: _futureProduk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
            child: CircularProgressIndicator(),
          );}

          if (snapshot.hasData) {
            List<ProdukModal> products = snapshot.data!;
            return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final ProdukModal product = products[index];
                  return Produk(product: product);
                });
          }
          return Center(child:Text("Ada Error saat mengambil ProdukModal ${snapshot.error}"));
        },
      ),
    );
  }
}

class Produk extends StatefulWidget {
  const Produk({
    super.key,
    required this.product,
  });

  final ProdukModal product;

  @override
  State<Produk> createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  bool diLike = false;

  void _tombolLike() {
    setState(() {
      diLike = !diLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailProductPage(product: widget.product)),
      ),
      child: GridTile(
        header: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Icon(Icons.star, color: Colors.amber,),
                Text(widget.product.rating.toString()) ,
              ]) ,
            IconButton(
                onPressed: () => _tombolLike(),
                icon: Icon(
                  diLike ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink,
                ))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 4,top: 36),
                    child: Image.network(
                      widget.product.gambar,
                    ))),
            Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.purple),
                ),
                child: Text(
                  widget.product.kategori.toUpperCase(),
                  style: const TextStyle(color: Colors.purple),
                )),
            Text(
              widget.product.judul,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatRupiah(widget.product.harga),
                  style: const TextStyle(
                      color: Colors.purpleAccent, fontWeight: FontWeight.bold),
                ),
                Text("${widget.product.terjual} Terjual")
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<ProdukModal>> ambilProduk() async {
  final respon = await http.get(Uri.parse("https://fakestoreapi.com/products"));
  if (respon.statusCode == 200) {
    final data = jsonDecode(respon.body) as List;
    return data.map((json) => ProdukModal.fromJson(json),).toList();
  }
  throw Exception('Gagal Memuat Data');
}

String formatRupiah(num price) {
  final formatRupiah =
      NumberFormat.currency(locale: 'ID_id', symbol: 'Rp. ', decimalDigits: 0);
  return formatRupiah.format(price * 15000);
}

class ProdukModal {
  final int id;
  final String judul;
  final String kategori;
  final num harga;
  final int terjual;
  final num rating;
  final String deskripsi;
  final String gambar;

  ProdukModal(
      {required this.judul,
      required this.kategori,
      required this.harga,
      required this.terjual,
      required this.rating,
      required this.deskripsi,
      required this.gambar,
      required this.id});

  factory ProdukModal.fromJson(Map<String, dynamic> json) {
    return ProdukModal(
      id: json['id'] as int,
      judul: json['title'] as String,
      kategori: json['category'] as String,
      harga: json['price'] as num,
      terjual: json['rating']['count'] as int,
      rating: json['rating']['rate'] as num,
      deskripsi: json['description'] as String,
      gambar: json['image'] as String,
    );
  }
}
