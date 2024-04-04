import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  String location; //location name for the UI
  String time; //time of the location
  String flag; //url to an asset flag icon
  String url; //location url for API endpoints
  bool isDayTime=true;//true or false if day time or not

  WorldTime (this.location,this.time,this.flag,this.url);

  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      //get properties form data
      String dateTime = data['utc_datetime'];
      String offSetHours = data['utc_offset'].substring(1, 3);
      String offSetMinutes = data['utc_offset'].substring(4, 6);

      //Create dateTime object
      DateTime now = DateTime.parse(dateTime);
      if(data['utc_offset'].substring(0,1) == '+') {
        now = now.add(Duration(hours: int.parse(offSetHours)));
        now = now.add(Duration(minutes: int.parse(offSetMinutes)));
      }
      else{
        now = now.subtract(Duration(hours: int.parse(offSetHours)));
        now = now.subtract(Duration(minutes: int.parse(offSetMinutes)));
      }

      //return the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat().add_jms().format(now);
    }
    catch(e){
      print("Caught Error $e");
      time = "Could not get time data";
    }
  }
}
