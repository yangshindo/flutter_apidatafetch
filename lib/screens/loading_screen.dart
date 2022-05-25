import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
      print(latitude);
      print(longitude);
      getData(); //função abaixo
    });
  }

  void getData() async {
    var url = await Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=' +
            latitude.toString() +
            '&lon=' +
            longitude.toString() +
            '&appid=91b179234010a025efa8cffdc13a878c');
    var response = await http.get(url);
    print(response.body);
  }

  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Text("Latitude = " +
                latitude.toString() +
                ", Longitude = " +
                longitude.toString())));
  }
}
