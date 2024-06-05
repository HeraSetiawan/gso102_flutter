import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewScreen(pesan: "Ganti Layar"))),
                child: Text("Replace Screen")),
            ElevatedButton(
                onPressed: () {
                  Future<dynamic> hasil = Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NewScreen(pesan: "Will You Marry Me"),
                      ));
                  hasil.then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value),
                            ),
                          ));
                },
                child: const Text("aku mau ngomong sesuatu")),
          ],
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  final String pesan;
  const NewScreen({super.key, required this.pesan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pesan,
                style: const TextStyle(fontSize: 26),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Ngaak')),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.green)),
                      onPressed: () => Navigator.pop(context, 'Happy Marriage'),
                      child: const Text('Ya')),
                ],
              )
            ],
          ),
        ));
  }
}
