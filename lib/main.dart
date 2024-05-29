import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  List page = [
    PageSatu(),
    PageDua(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apo Kabar"),
      ),
      body: page.elementAt(index),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.green.shade200,
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.chat), label: "Chat"),
          NavigationDestination(
              icon: Icon(Icons.circle_notifications), label: "notif")
        ],
      ),
    );
  }
}

class PageSatu extends StatelessWidget {
  const PageSatu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children:const [
      ListTile(
        leading: CircleAvatar(foregroundImage: NetworkImage("https://picsum.photos/200"),),
        title: Text("Burger Keju"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rp. 20.000"),
            Icon(Icons.star, color: Colors.amber,)
          ],
        ),
      ),
    ]);
  }
}

class PageDua extends StatelessWidget {
  const PageDua({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Halaman 2"),
    );
  }
}
