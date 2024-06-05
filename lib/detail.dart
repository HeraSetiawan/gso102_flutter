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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NewScreen(pesan: "Will You Marry Me"),
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
                      child: Text('Ngaak')),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ya')),
                ],
              )
            ],
          ),
        ));
  }
}
