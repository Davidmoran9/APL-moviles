import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/poliza_controller.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PolizaController(),
      child: MaterialApp(
        title: 'Sistema de Pólizas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
