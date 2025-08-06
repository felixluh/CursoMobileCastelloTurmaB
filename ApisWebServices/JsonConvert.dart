// Teste de conversão de Json <-> Dart
import 'dart:convert'; //nativa -> não precisa instalar nada.

void main() { 
//Tenho um texto em formato de Json
  String UsuarioJson = '''{
                            "id":"1ab2",
                            "user": "usuario1",
                            "nome": "Pedro",
                            "idade":25,
                            "cadastrado": true
                            }''';
//Para manipular o texto,
// -> converter Json em Map
Map<String,dynamic> usuario = json.decode(UsuarioJson);
//mainupulando informações do Json -> Map
print(usuario["idade"]);
usuario["idade"] = 26;
// conevrter(encode) de Map -> Json
UsuarioJson = json.encode(usuario);
//tenho novamente o Json em formato de texto
print(UsuarioJson);

}

