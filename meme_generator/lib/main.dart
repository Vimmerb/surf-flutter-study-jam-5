import 'package:flutter/material.dart';
import 'package:meme_generator/ui/screens/meme_generator_screen.dart';
import 'package:provider/provider.dart';

import 'models.dart/meme_generator_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
      // Создаем экземпляр MemeGeneratorModel
      create: (context) => MemeGeneratorModel(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MemeGeneratorScreen(),
    );
  }
}
