import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/store.dart';

class DetailProductPage extends StatelessWidget {
  final ProdukModal product;
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
                child: Image.network(product.gambar)),
            Text(product.kategori.toUpperCase()),
            Text(product.judul),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatRupiah(product.harga),
                  style: TextStyle(fontSize: 18),
                ),
                Text("${product.terjual} Terjual",
                    style: TextStyle(fontSize: 18)),
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(product.deskripsi),
            ),
            const Text('Produk Serupa',style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 100,
              child: ProdukSerupa(kategori: product.kategori,)
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 50,
            color: Colors.deepOrange,
            child: Center(child: Text("Tambah Keranjang", style: TextStyle(color: Colors.white,fontSize: 20),)),
          ),
          Expanded(
            child: Container(
              height: 50,
              color: Colors.teal,
              child: Center(child: Text("Belanja sekarang", style: TextStyle(color: Colors.white, fontSize: 20),)),
            
            ),
          ),
        ],
      ),
    );
  }
}

class ProdukSerupa extends StatelessWidget {
  const ProdukSerupa({super.key, required this.kategori});

  final String kategori;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ambilProdukSerupa(kategori), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List listProduk = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listProduk.length,
            itemBuilder: (context, index) {
             final produkSerupa = listProduk[index];
             return GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,MaterialPageRoute(
                  builder: (context) => DetailProductPage(product: produkSerupa),
                  )
                ),
               child: Container(
                width: 140,
                margin: EdgeInsets.symmetric(vertical: 8),
                 child: Column(
                   children: [
                     Expanded(child: Image.network(produkSerupa['image'])),
                     Text(produkSerupa['title'], overflow: TextOverflow.ellipsis,),
                     Text(formatRupiah(produkSerupa['price'])),
                   ],
                 ),
               ),
             );
            },
            );
        }

        return const Center(child: CircularProgressIndicator(),);
      },);
  }
}

Future<List> ambilProdukSerupa(String kategori) async {
  final respon = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$kategori"));
  if (respon.statusCode == 200) {
    final produkSerupa = jsonDecode(respon.body);
    return produkSerupa as List;
  }
  throw Exception("Gagal Ambil Produk Serupa"); 
}