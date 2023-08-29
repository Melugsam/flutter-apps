import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'package:weather_app/widgets/data_service.dart';
import 'widgets/search_action_button.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(),
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
    double widthPadding = screenWidth*0.05;
    return Scaffold(
      appBar: AppBar(
        actions: [
          SearchActionButton(prevContext:context)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthPadding, vertical: 16.0),
        child: Center(
          child: Column(
            children: [
              DataService(screenWidth)
            ],
          ),
        ),
      ),
    );
  }
}
