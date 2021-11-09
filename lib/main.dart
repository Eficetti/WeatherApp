// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: 'Weather App',
      home: Home(),
    ));

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  double temperatura = 0;
  var descripcion = ' ';
  var actual = ' ';
  var humedad = 0;
  double viento = 0;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=-33.1236&lon=-64.3492&units=metric&appid=d610f567c28f1d2151a05a8681367d8d&lang=es'));
    var decode = jsonDecode(response.body);
    setState(() {
      temperatura = decode['main']['temp'];
      descripcion = decode['weather'][0]['description'];
      actual = decode['weather'][0]['description'];
      humedad = decode['main']['humidity'];
      viento = decode['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/weather.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Rio cuarto',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[900]),
                    ),
                  ),
                  Text(
                    temperatura != null
                        ? temperatura.toString() + '\u00B0'
                        : 'Cargando',
                    style: TextStyle(
                      color: Colors.amber[900],
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      actual != null ? actual.toString() : 'Cargando',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[900]),
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf,
                        color: Colors.yellow),
                    title: Text('Temperatura'),
                    trailing: Text(temperatura != null
                        ? temperatura.toString() + '52\u00B0'
                        : 'Cargando'),
                  ),
                  ListTile(
                    leading:
                        FaIcon(FontAwesomeIcons.cloud, color: Colors.yellow),
                    title: Text('Clima'),
                    trailing: Text(descripcion != null
                        ? descripcion.toString() + '\u00B0'
                        : 'Cargando'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun, color: Colors.yellow),
                    title: Text('Humedad'),
                    trailing: Text(humedad != null
                        ? humedad.toString() + '\u00B0'
                        : 'Cargando'),
                  ),
                  ListTile(
                    leading:
                        FaIcon(FontAwesomeIcons.wind, color: Colors.yellow),
                    title: Text('Viento'),
                    trailing: Text(viento != null
                        ? viento.toString() + '\u00B0'
                        : 'Cargando'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
