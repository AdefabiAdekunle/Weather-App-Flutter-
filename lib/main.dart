import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(title: "Weather App", home: Home()),
  );
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  double temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Lagos,ng&APPID=d7c7540cded670ff3e368b05a8db9194");
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results["main"]["temp"];
      this.description = results["weather"][0]["description"];
      this.currently = results["weather"][0]["main"];
      this.humidity = results["main"]["humidity"];
      this.windSpeed = results["wind"]["speed"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(color: Colors.amberAccent),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Currently in Lagos,Nigeria",
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  Text(
                    temp != null
                        ? (temp - 273.15).toString() + "\u00B0" + "C"
                        : "Loading",
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null ? currently.toString() : "Loading",
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 70,bottom: 20,left: 20,right: 20),
            child: ListView(
              children: <Widget>[
                Center(
                  child:Text("Weather Analysis:\n",style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                ),
                ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperature"),
                  trailing: Text(temp != null
                      ? (temp - 273.15).toString() + "\u00B0" + "C"
                      : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Weather"),
                  trailing: Text(
                      description != null ? description.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Temperature Humidity"),
                  trailing:
                      Text(humidity != null ? humidity.toString() : "Loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Wind Speed"),
                  trailing: Text(
                      windSpeed != null ? windSpeed.toString() : "Loading"),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
