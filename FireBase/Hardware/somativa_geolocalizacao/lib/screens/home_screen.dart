import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
// Importe seu AuthService e seu modelo PontoRegistro aqui.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Função para simular o Registro de Ponto
  void _registrarPonto(BuildContext context, Position? position, double distance) {
    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: Localização não disponível para registro.')),
      );
      return;
    }
    
    // **AQUI você faria a integração com o Firebase (Firestore)**
    // 1. Criar um objeto PontoRegistro
    // 2. Enviar para o Firestore
    
    String status = distance <= 100 ? "REGISTRADO" : "FORA DO RAIO";
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ponto $status! Distância: ${distance.toStringAsFixed(2)}m.'),
        backgroundColor: distance <= 100 ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // O Consumer escuta as mudanças no LocationService
    return Consumer<LocationService>(
      builder: (context, locationService, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Registro de Ponto - Home")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Status da Localização:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Exibe a mensagem atualizada pelo Service
                Text(
                  locationService.locationMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                
                ElevatedButton.icon(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    
                    // 1. Tenta obter a localização e verifica se está dentro do raio
                    Position? position = await locationService.getCurrentLocation();
                    
                    if (position != null) {
                      double distance = await locationService.getDistanceToCompany(position);

                      // 2. Executa a checagem e registra
                      if (distance <= 100) {
                        // Está dentro!
                        _registrarPonto(context, position, distance);
                      } else {
                        // Está fora!
                        _registrarPonto(context, position, distance); 
                      }
                    }
                  },
                  icon: const Icon(Icons.pin_drop),
                  label: const Text("Registrar Ponto (Checar 100m)"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}