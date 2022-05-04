import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=> runApp( const MaterialApp(
  home : Home(),
  title: "WEATHER FORECAST",
));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var des;
  var curr;
  var hum;
  var win;
  Future getWeather() async{
    http.Response response= await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=13.0827&lon=80.255043&appid=da39c350c89089225666b3fc2e219cdd"));
    var res=jsonDecode(response.body);
    setState(() {
      this.temp=res['main']['temp']-273.15;
      this.des=res['weather'][0]['description'];
      this.hum=res['main']['humidity'];
      this.curr=res['weather'][0]['main'];
      this.win=res['wind']['speed'];
    });
  }
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF8A80),
      body: Column(

          children: <Widget>[

            Container(
              height: MediaQuery.of(context).size.height/2.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child:
              Text("\n\nWEATHER IN CHENNAI\n\n"+temp.toString()+"\u00B0C" + "\n\n" +  curr.toString(),
                  style: TextStyle(
                    color: Color(0xFFFF8A80),
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center),
            ),
            Expanded(child:
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("TEMPERATURE",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),),
                    trailing: Text(
                      temp!=null? temp.toString()+"\u00B0C": "Loading...",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("WEATHER",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),),
                    trailing: Text(curr!=null? curr.toString(): "Loading...",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("HUMIDITY",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),),
                    trailing: Text(hum!=null?hum.toString()+"%":"Loading...",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("WIND SPEED",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,),),
                    trailing: Text(win!=null?win.toString()+ " kmph":"Loading...",style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),),
                  )
                ],

              ),
            ))
          ]
      ),
    );
  }
}
