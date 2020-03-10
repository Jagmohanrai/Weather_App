import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:wheater_app/wheathermodel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cityname = TextEditingController();
  WeatherData currentdata;

  Future getdata(String city) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2';
    final response = await http.Client().get(url);

    if (response.statusCode != 200) {
      showDialog(
          context: context,
          builder: (context) {
            return (AlertDialog(
              title: Text('Error Occurred'),
              content: Text(
                  'We are facing problem in fetching the data of given city'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            ));
          });
    } else {
      nextstep(response.body);
    }
  }

  nextstep(value) {
    final result = json.decode(value);
    final res = result["main"];
    currentdata = WeatherData.fromJson(res);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                  child: Container(
                child: FlareActor(
                  "assets/WorldSpin.flr",
                  fit: BoxFit.contain,
                  animation: "roll",
                ),
                height: 300,
                width: 300,
              )),
            ),
            currentdata == null
                ? Container(
                    padding: EdgeInsets.only(
                      left: 32,
                      right: 32,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Search Weather",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Instanly",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: cityname,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            hintText: "City Name",
                            hintStyle: TextStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            onPressed: () {
                              getdata(cityname.text);
                            },
                            color: Colors.lightBlue,
                            child: Text(
                              "Search",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              (cityname.text).toUpperCase(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (currentdata.temp - 272.5).round().toString() +
                                  "C",
                              style: TextStyle(fontSize: 50),
                            ),
                            Text(
                              "Temprature",
                              style: TextStyle(fontSize: 14),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      (currentdata.temp_min - 272.5)
                                              .round()
                                              .toString() +
                                          "C",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      "Min Temprature",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      (currentdata.temp_max - 272.5)
                                              .round()
                                              .toString() +
                                          "C",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      "Max Temprature",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: () {
                                setState(() {
                                  currentdata = null;
                                });
                              },
                              color: Colors.lightBlue,
                              child: Text(
                                'Reset Data',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ],
                        ),
                        height: 300,
                        width: double.infinity,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
