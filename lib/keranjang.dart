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
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProviderProduk>(
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
              ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 100,
            child:const Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Total Qty'),
                  Text('0'),
                ],),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Total Bayar'),
                  Text('0'),
                ],),
              ],
            ),
          ),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                ElevatedButton.icon(
                  onPressed: () {}, 
                  style:const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.purple),
                    foregroundColor: WidgetStatePropertyAll(Colors.white)
                    ),
                  
                  label: Text('Cash on Delivery'),
                  icon: Icon(Icons.pin_drop),
                  ),
                ElevatedButton.icon(
                  onPressed:(){}, 
                  label: Text('Transfer'),
                  icon: Icon(Icons.qr_code),
                  ),
              ],),
            )
        ],
      )
        );
  }
}