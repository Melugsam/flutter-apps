import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/search_model.dart';
import 'widgets/search_action_button.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SearchModel(),
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widthPadding = screenWidth*0.05;
    double heightPadding = screenHeight*0.02;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          SearchActionButton(prevContext:context)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthPadding, vertical: 16.0),
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
