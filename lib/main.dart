import 'package:flutter/material.dart';
import 'package:myapp/detail.dart';
void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  List page = [
    const PageSatu(),
    const PageDua(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apo Kabar"),
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
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat), label: "Chat"),
          NavigationDestination(
              icon: Icon(Icons.circle_notifications), label: "notif")
        ],
      ),
    );
  }
}

class PageSatu extends StatefulWidget {
  const PageSatu({
    super.key,
  });

  @override
  State<PageSatu> createState() => _PageSatuState();
}

class _PageSatuState extends State<PageSatu> {
  bool isFavorit = false;
  void like(){
    setState(() {
      isFavorit = !isFavorit;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailPage())),
        trailing: IconButton(
          onPressed: like, 
          icon: Icon(
            isFavorit ? Icons.favorite : Icons.favorite_border, 
            color: Colors.pink,)),
        leading: const CircleAvatar(foregroundImage: NetworkImage("https://picsum.photos/200"),),
        title: const Text("Burger Keju"),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rp. 20.000"),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber,),
                Icon(Icons.star, color: Colors.amber,),
                Icon(Icons.star, color: Colors.amber,),
                Icon(Icons.star, color: Colors.grey,),
                Icon(Icons.star, color: Colors.grey,),
              ],
            )
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
