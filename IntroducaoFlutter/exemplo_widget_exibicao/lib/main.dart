import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  //Construtor de Widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição")),
      body: Center(
        child: Column(
          children: [
            Text(
              "Exemplo de Texto",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              "Texto Personalizado",
              style: TextStyle(
                fontSize: 24,
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                wordSpacing: 2,
                decoration: TextDecoration.underline,
              ),
            ),
            // Icones
            Icon(Icons.star, size: 50, color: Colors.amber),
            IconButton(
              onPressed: () => print('Icone Pressionado'),
              icon: Icon(Icons.add_a_photo),
              iconSize: 50,
            ),
            // Imagens
            Image.network(
              "https://acdn-us.mitiendanube.com/stores/001/776/325/products/homem-aranha-digital-painel-still1-7c6d8a7721a8ba0e7516754450480051-1024-1024.jpg",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/img/emmafrost.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            // Box para exibição de Imagem
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/img/teste.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/img/emmafrost.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
