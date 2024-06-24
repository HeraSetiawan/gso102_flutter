import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/store.dart';

class DetailProductPage extends StatelessWidget {
  final Map<String, dynamic> product;
  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Produk"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                height: 200,
                margin: EdgeInsets.only(bottom: 8),
                child: Image.network(product['image'])),
            Text(product['category'].toUpperCase()),
            Text(product['title']),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatRupiah(product['price']),
                  style: TextStyle(fontSize: 18),
                ),
                Text("${product['rating']['count']} Terjual",
                    style: TextStyle(fontSize: 18)),
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(product['description']),
            ),
            const Text('Produk Serupa',style: TextStyle(fontSize: 18)),
            const SizedBox(
              height: 100,
              child: ProdukSerupa()
            ),
          ],
        ),
      ),
    );
  }
}

class ProdukSerupa extends StatelessWidget {
  const ProdukSerupa({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ambilProdukSerupa(), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List listProduk = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listProduk.length,
            itemBuilder: (context, index) {
             final produkSerupa = listProduk[index];
             return Container(
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 8),
               child: Column(
                 children: [
                   Expanded(child: Image.network(produkSerupa['image'])),
                   Text(produkSerupa['title'], overflow: TextOverflow.ellipsis,),
                   Text(formatRupiah(produkSerupa['price'])),
                 ],
               ),
             );
            },
            );
        }

        return const Center(child: CircularProgressIndicator(),);
      },);
  }
}

Future<List> ambilProdukSerupa() async {
  final respon = await http.get(Uri.parse("https://fakestoreapi.com/products/category/jewelery"));
  if (respon.statusCode == 200) {
    final produkSerupa = jsonDecode(respon.body);
    return produkSerupa as List;
  }
  throw Exception("Gagal Ambil Produk Serupa"); 
}