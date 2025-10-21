import 'package:cloud_firestore/cloud_firestore.dart';

class PontoRegistro {
  final String userId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String registroId;

  PontoRegistro({
    required this.userId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.registroId,
  });

  // Converte o objeto para o formato do Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'timestamp': Timestamp.fromDate(timestamp),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Cria um objeto a partir de um DocumentSnapshot do Firestore
  factory PontoRegistro.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PontoRegistro(
      userId: data['userId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
      registroId: doc.id,
    );
  }
}