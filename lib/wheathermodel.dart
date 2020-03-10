class WeatherData{
   final temp;
  final pressure;
  final  humidity;
  final temp_max;
  final  temp_min;
 
WeatherData(this.temp, this.pressure, this.humidity, this.temp_max, this.temp_min);

 factory WeatherData.fromJson(Map<String, dynamic> json){
    return WeatherData(
      json["temp"],
      json["pressure"],
      json["humidity"],
      json["temp_max"],
      json["temp_min"]
    );
  }
}