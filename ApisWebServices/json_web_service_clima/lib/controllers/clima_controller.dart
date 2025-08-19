import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/model/clima_model.dart';

class ClimaController {
  final String _apiKey = "090d96c99a627945e44dad999a406c7d";

  //me´todo para buscar a informção do clima de uma cidade
  Future<ClimaModel?> buscarClima(String cidade) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      return ClimaModel.fromJson(dados);
    }else {
      return  null;
    }
    }
  }

