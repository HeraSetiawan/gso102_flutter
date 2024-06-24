import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/detail_product.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.store),
        title: const Text("Toko WakEbok"),
      ),
      body: FutureBuilder(
        future: ambilProduk(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                ),
              itemCount: products.length,
              itemBuilder: (context,index) {
                final Map<String, dynamic> product = products[index];
                return Produk(product: product);
              }
            );
          }

          return const Center(child: CircularProgressIndicator(),);
        },
        ),
    );
  }
}

class Produk extends StatelessWidget {
  const Produk({
    super.key,
    required this.product,
  });

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => DetailProductPage(product:product)),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 12),
            height: 200,
            child: Image.network(product['image']))),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.purple),
            ),
            child: Text(product['category'].toUpperCase(), 
            style:const TextStyle(color: Colors.purple),)),
          Text(product['title'], 
          style: const TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatRupiah(product['price']), 
              style: const TextStyle(color: Colors.purpleAccent,fontWeight: FontWeight.bold),),
              Text("${product['rating']['count']} Terjual")
            ],
          )
        ],
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

String formatRupiah(num price){
 final formatRupiah = NumberFormat.currency(locale: 'ID_id',symbol: 'Rp. ',decimalDigits: 0);
  return formatRupiah.format(price * 15000);
}