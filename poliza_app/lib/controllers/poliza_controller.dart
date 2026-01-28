import 'package:flutter/material.dart';
import '../models/poliza_model.dart';
import '../services/api_service.dart';

class PolizaController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  bool _isLoading = false;
  String? _errorMessage;
  PolizaResponse? _polizaResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  PolizaResponse? get polizaResponse => _polizaResponse;

  Future<bool> crearPoliza(PolizaRequest poliza) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _polizaResponse = await _apiService.crearPoliza(poliza);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> buscarPoliza(String nombre) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _polizaResponse = await _apiService.buscarPolizaPorNombre(nombre);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearPoliza() {
    _polizaResponse = null;
    notifyListeners();
  }
}
