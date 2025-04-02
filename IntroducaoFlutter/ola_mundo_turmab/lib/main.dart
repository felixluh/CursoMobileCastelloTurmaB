import 'package:flutter/material.dart'; //Android

void main(){ //rodar a aplicação
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Meu Primeiro App"),
        ),
        body: Center(
          child: Text("Olá Mundo!!!"),
        ),
      ) 

    );
  }
}