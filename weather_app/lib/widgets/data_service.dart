import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DataService extends StatelessWidget {
    final double screenWidth;
  DataService(this.screenWidth);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadedState) {
          return Column(
            children: [
              Text(state.weatherData.name.toString(),style: GoogleFonts.lato(fontSize: 40, fontWeight: FontWeight.w600)),
              Text("${state.weatherData.fixTemp(state.weatherData.currTemp)}°C", style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w400)),
              Image.memory(Uint8List.fromList(state.weatherData.iconBytes)),
              Text(state.weatherData.weatherDescription, style: GoogleFonts.lato(fontSize: 26, fontWeight: FontWeight.w300)),
            ],
          );
        } else if (state is WeatherLoadingState) {
          return CircularProgressIndicator();
        } else if (state is WeatherErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return Container();
        }
      },
    );
  }
}
