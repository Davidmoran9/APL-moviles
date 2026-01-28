import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/poliza_controller.dart';
import '../models/poliza_model.dart';

class CrearPolizaView extends StatefulWidget {
  const CrearPolizaView({Key? key}) : super(key: key);

  @override
  State<CrearPolizaView> createState() => _CrearPolizaViewState();
}

class _CrearPolizaViewState extends State<CrearPolizaView> {
  final _formKey = GlobalKey<FormState>();
  final _propietarioController = TextEditingController();
  final _valorSeguroController = TextEditingController();
  final _accidentesController = TextEditingController();
  
  String _modeloSeleccionado = 'A';
  String _rangoEdadSeleccionado = '18-23';
  bool _aceptaTerminos = false;

  @override
  void dispose() {
    _propietarioController.dispose();
    _valorSeguroController.dispose();
    _accidentesController.dispose();
    super.dispose();
  }

  int _getRangoEdad(String rango) {
    switch (rango) {
      case '18-23':
        return 20; // Edad promedio
      case '23-55':
        return 40; // Edad promedio
      case '55+':
        return 60; // Edad promedio
      default:
        return 30;
    }
  }

  void _crearPoliza() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final poliza = PolizaRequest(
      propietario: _propietarioController.text,
      valorSeguroAuto: double.parse(_valorSeguroController.text),
      modeloAuto: _modeloSeleccionado,
      accidentes: int.parse(_accidentesController.text),
      edadPropietario: _getRangoEdad(_rangoEdadSeleccionado),
    );

    final controller = Provider.of<PolizaController>(context, listen: false);
    final success = await controller.crearPoliza(poliza);

    if (success && mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¡Póliza Creada!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Propietario: ${controller.polizaResponse?.propietario}'),
              Text('Modelo: ${controller.polizaResponse?.modeloAuto}'),
              Text('Costo Total: \$${controller.polizaResponse?.costoTotal.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.errorMessage ?? 'Error al crear póliza'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text('Crear Póliza'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Consumer<PolizaController>(
        builder: (context, controller, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    'Crear Póliza',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Campo Propietario
                          TextFormField(
                            controller: _propietarioController,
                            decoration: InputDecoration(
                              labelText: 'Propietario',
                              hintText: 'Ingrese nombre completo',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese el nombre';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Campo Valor del Seguro
                          TextFormField(
                            controller: _valorSeguroController,
                            decoration: InputDecoration(
                              labelText: 'Valor del seguro',
                              hintText: 'Ingrese el valor',
                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixText: '\$ ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese el valor';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Ingrese un valor válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Modelo de auto
                          const Text(
                            'Modelo de auto:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RadioListTile<String>(
                            title: const Text('Modelo A'),
                            value: 'A',
                            groupValue: _modeloSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                _modeloSeleccionado = value!;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          RadioListTile<String>(
                            title: const Text('Modelo B'),
                            value: 'B',
                            groupValue: _modeloSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                _modeloSeleccionado = value!;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          RadioListTile<String>(
                            title: const Text('Modelo C'),
                            value: 'C',
                            groupValue: _modeloSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                _modeloSeleccionado = value!;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          const SizedBox(height: 24),

                          // Edad propietario
                          const Text(
                            'Edad propietario:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RadioListTile<String>(
                            title: const Text('Mayor igual a 18 y menor a 23'),
                            value: '18-23',
                            groupValue: _rangoEdadSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                _rangoEdadSeleccionado = value!;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          RadioListTile<String>(
                            title: const Text('Mayor igual a 23 y menor a 55'),
                            value: '23-55',
                            groupValue: _rangoEdadSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                _rangoEdadSeleccionado = value!;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          RadioListTile<String>(
                            title: const Text('Mayor igual 55'),
                            value: '55+',
                            groupValue: _rangoEdadSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                _rangoEdadSeleccionado = value!;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          const SizedBox(height: 20),

                          // Número de accidentes
                          TextFormField(
                            controller: _accidentesController,
                            decoration: InputDecoration(
                              labelText: 'Número de accidentes',
                              hintText: 'Ingrese el número',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese el número de accidentes';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Ingrese un número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Checkbox términos
                          CheckboxListTile(
                            title: const Text('Acepto términos y condiciones'),
                            value: _aceptaTerminos,
                            onChanged: (value) {
                              setState(() {
                                _aceptaTerminos = value ?? false;
                              });
                            },
                            activeColor: Colors.teal,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          const SizedBox(height: 30),

                          // Botón crear
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: controller.isLoading ? null : _crearPoliza,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: controller.isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                      'CREAR PÓLIZA',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
