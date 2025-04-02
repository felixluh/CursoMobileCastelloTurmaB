import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("Item $_selectedIndex selecionado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicativo Super Interessante"),
        actions: [
          IconButton(
            onPressed: () => print("Menu"),
            icon: Icon(Icons.menu, color: Colors.blueGrey, size: 45),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Bem-Vindo(a)",
              style: TextStyle(fontSize: 30, color: const Color.fromARGB(200, 112, 114, 255)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/img/socorro.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Emma Frost",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              "Rainha Branquela dos X-Mens",
              style: TextStyle(fontSize: 15, color: const Color.fromARGB(118, 0, 0, 0)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: "Voltar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notificações",
          ),
        ],
      ),
    );
  }
}
