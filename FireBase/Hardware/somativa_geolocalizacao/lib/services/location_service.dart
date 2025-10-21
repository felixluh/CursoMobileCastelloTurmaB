import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/constants.dart';

class LocationService extends ChangeNotifier {
  String locationMessage = "";

  // Verifica se o serviço de localização está habilitado e a permissão
  Future<bool> _checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationMessage = "Serviço de Localização está Desativado";
      notifyListeners();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        locationMessage = "Permissão de Localização Negada";
        notifyListeners();
        return false;
      }
    }
    return true;
  }

  // Pega a localização atual do usuário
  Future<Position?> getCurrentLocation() async {
    if (!(await _checkAndRequestPermission())) {
      return null;
    }
    
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      locationMessage = "Localização Atual: Lat ${position.latitude.toStringAsFixed(4)}, Lon ${position.longitude.toStringAsFixed(4)}";
      notifyListeners();
      return position;
    } catch (e) {
      locationMessage = "Erro ao obter localização: ${e.toString()}";
      notifyListeners();
      return null;
    }
  }

  // **Funcionalidade Central do Projeto: Checagem do Raio de 100m**
  Future<double> getDistanceToCompany(Position userPosition) async {
    // Calcula a distância em metros entre a posição do usuário e a posição da empresa
    double distanceInMeters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      COMPANY_LATITUDE,
      COMPANY_LONGITUDE,
    );
    return distanceInMeters;
  }

  Future<bool> isWithinWorkingRange() async {
    Position? currentPosition = await getCurrentLocation();
    if (currentPosition == null) {
      return false; // Não pode registrar se não tiver localização
    }

    double distance = await getDistanceToCompany(currentPosition);

    // Atualiza a mensagem para mostrar a distância
    locationMessage += "\nDistância até a Empresa: ${distance.toStringAsFixed(2)}m";
    notifyListeners();
    
    // Retorna verdadeiro se estiver dentro do limite
    return distance <= MAX_DISTANCE_METERS;
  }
}