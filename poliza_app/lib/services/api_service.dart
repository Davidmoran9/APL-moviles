import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/poliza_model.dart';

class ApiService {
  // Cambia esta URL según tu configuración
  static const String baseUrl = 'http://localhost:9090/bdd_dto';
  
  Future<PolizaResponse> crearPoliza(PolizaRequest poliza) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/poliza'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(poliza.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PolizaResponse.fromJson(data);
      } else {
        throw Exception('Error al crear póliza: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<PolizaResponse> buscarPolizaPorNombre(String nombre) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/poliza/usuario?nombre=$nombre'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PolizaResponse.fromJson(data);
      } else if (response.statusCode == 400) {
        // Error del backend (ej: propietario no encontrado)
        throw Exception('${response.body}');
      } else {
        throw Exception('Error al buscar póliza: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('Propietario no encontrado')) {
        throw Exception('Propietario no encontrado con nombre: $nombre');
      }
      throw Exception('Error de conexión: $e');
    }
  }
}
