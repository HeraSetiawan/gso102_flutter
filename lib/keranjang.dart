import 'package:flutter/material.dart';
import 'package:myapp/provider_produk.dart';
import 'package:myapp/store.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Keranjang'),
      ),
      body: Consumer<ProviderProduk>(
        builder: (context, value, child) =>
           ListView.builder(
            itemCount: value.jmlKeranjang,
            itemBuilder: (context, index) {
              final produk = value.listProduk[index];
              return Dismissible(
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  Provider.of<ProviderProduk>(context,listen: false).hapusKeranjang(produk);
                },
                key: ValueKey(produk.id),
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(Icons.delete,color: Colors.white,size: 32,),
                ),
                child: ListTile(
                  leading: Image.network(produk.gambar, width: 45,),
                  title: Text(produk.judul),
                  subtitle: Text(formatRupiah(produk.harga)),
                ),
              );
            }),
        )
        );
  }
}