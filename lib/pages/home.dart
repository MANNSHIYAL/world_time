import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ?  data : ModalRoute.of(context)!.settings.arguments as Map;


    //  set backgroundImage
    String bgImage = data["isDayTime"] ? "day.png" : "night.png";
    Color bgColor = data["isDayTime"] ? Colors.blue[400] as Color: Colors.indigo[700] as Color;
      return Scaffold(
      body: Container(
        color: bgColor,
        child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/$bgImage"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0,120.0,0.0, 0.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          dynamic result = await Navigator.pushNamed(context, "/location");
                          setState(() {
                            data = {
                              "location" : result["location"] as String,
                              "flag" : result["flag"] as String,
                              "time" : result["time"] as String,
                              "isDayTime" : result["isDayTime"] as bool,
                            };
                          });
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                      ),
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                          "Edit Location",
                          style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height:  20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data["location"],
                          style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      data["time"],
                      style: TextStyle(
                        fontSize: 66.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
    )
      );
  }
}
