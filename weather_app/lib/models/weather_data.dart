import 'dart:typed_data';

class WeatherData {
  final String name;
  final String weatherDescription;
  final String icon;
  final Uint8List iconBytes;
  final double currTemp;
  final double minTemp;
  final double maxTemp;
  final int humidity;

  WeatherData({
    required this.name,
    required this.weatherDescription,
    required this.icon,
    required this.iconBytes,
    required this.currTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
  });

  String get iconUrl{
    return "https://openweathermap.org/img/wn/$icon@2x.png";
  }

  String fixTemp(double currTemp){
    String newTemp="";
    String temp = currTemp.toString().replaceAll(RegExp(r'\.0*$'), '');
    for (int i=0; i<temp.length; i++){
      if (temp[i]!='.'){
        newTemp+=temp[i];
      }
      else{
        break;
      }
    }
    return newTemp;
  }
}
