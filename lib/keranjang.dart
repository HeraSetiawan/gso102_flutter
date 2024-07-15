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
          title: const Text('Keranjang'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ProviderProduk>(
                builder: (context, value, child) => ListView.builder(
                    itemCount: value.jmlKeranjang,
                    itemBuilder: (context, index) {
                      final produk = value.listProduk[index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          Provider.of<ProviderProduk>(context, listen: false)
                              .hapusKeranjang(produk);
                        },
                        key: ValueKey(produk.id),
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            produk.gambar,
                            width: 45,
                          ),
                          title: Text(produk.judul),
                          subtitle: Text(formatRupiah(produk.harga)),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 100,
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Qty'),
                      Consumer<ProviderProduk>(
                          builder: (context, value, child) =>
                              Text('${value.jmlKeranjang}')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Bayar'),
                      Consumer<ProviderProduk>(
                          builder: (context, value, child) =>
                              Text(value.hitungTotal())),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Nama Pembeli')),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Text('Alamat Penerima'),
                                        border: OutlineInputBorder()),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Kirim')),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.purple),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)),
                    label: const Text('Cash on Delivery'),
                    icon: const Icon(Icons.pin_drop),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text('Transfer'),
                    icon: const Icon(Icons.qr_code),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
