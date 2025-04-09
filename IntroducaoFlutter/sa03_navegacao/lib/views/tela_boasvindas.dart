import 'package:flutter/material.dart';

class TelaBoasvindas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bem-Vindo!"),centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bem-Vindo ao nosso app", style: TextStyle(fontSize: 20) ,),
            ElevatedButton(
              onPressed: ()=> Navigator.pushNamed(context, "/cadastro"),
               child: Text("Iniciar cadastro")),
          ],
        ),
      ),
    );
  }
}