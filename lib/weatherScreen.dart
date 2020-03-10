import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:wheater_app/wheathermodel.dart';


class WeatherScreen extends StatelessWidget {
 final response;
  WeatherScreen(this.response);
 
  
  
  @override
  Widget build(BuildContext context) {

    final result = json.decode(response);
    final res= result['main'];
    WeatherData newdata = WeatherData.fromJson(res);
    return Scaffold(
      body: Center(child: Column(
        children: <Widget>[
          Text(newdata.temp),
          Text(newdata.temp_max),
          Text(newdata.temp_min),
          Text(newdata.pressure),
          Text(newdata.humidity),
        ],
      ),)
    );
  }
}