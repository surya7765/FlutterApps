import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isday;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);

      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));
      now = now.add(Duration(minutes: int.parse(offset.substring(4, 6))));

      // now.hour = now.hour +  3;

      // print(isday);

      time = DateFormat.jm().format(now);
      isday = now.hour > 4 && now.hour < 18;
      print(now.hour);
    } catch (e) {
      print('Error is: $e');
      time = 'Wrong location';
    }
  }
}

// inst.getTime();
