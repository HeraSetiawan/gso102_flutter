import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/store.dart';
import 'package:myapp/keranjang.dart';
import 'package:myapp/provider_produk.dart';
import 'package:provider/provider.dart';
import 'package:myapp/produk_modal.dart';

class DetailProductPage extends StatelessWidget {
  final ProdukModal product;
  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Produk"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, 
              MaterialPageRoute(builder: (context) => KeranjangPage(),),),
              icon: Badge(
                label: Consumer<ProviderProduk>(
                  builder: (context, produk, child) => Text('${produk.jmlKeranjang}')),
                child:const Icon(Icons.shopping_bag)),
            )
        ],
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
          InkWell(
            onTap: () {
              Provider.of<ProviderProduk>(context,listen: false).tambahKeranjang(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Berhasil menambahkan ${product.judul} ke keranjang'))
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: 100,
              height: 50,
              color: Colors.deepOrange,
              child: Center(child:  Icon(Icons.add_shopping_cart,color: Colors.white,),),
            ),
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
        if (snapshot.hasError) {
          Center(child: Text('ada error tampilan produk serupa ${snapshot.error}'),);
        }
        if (snapshot.hasData) {
          final List<ProdukModal> listProduk = snapshot.data!;
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
                     Expanded(child: Image.network(produkSerupa.gambar)),
                     Text(produkSerupa.judul, overflow: TextOverflow.ellipsis,),
                     Text(formatRupiah(produkSerupa.harga)),
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

Future<List<ProdukModal>> ambilProdukSerupa(String kategori) async {
  final respon = await http.get(Uri.parse("https://fakestoreapi.com/products/category/$kategori"));
  if (respon.statusCode == 200) {
    final jsonList = jsonDecode(respon.body) as List;
    return jsonList.map((json) => ProdukModal.fromJson(json),).toList();
    
  }
  throw Exception("Gagal Ambil Produk Serupa"); 
}