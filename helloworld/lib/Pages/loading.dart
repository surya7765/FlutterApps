import 'package:flutter/material.dart';
import 'package:helloworld/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // String time = 'loading';

  void worldtime() async {
    WorldTime inst = WorldTime(
        location: 'Asia',
        flag:
            'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2020/04/eu2zm8ixqaaa09p-1586145604.jpg',
        url: 'Asia/Kolkata');
    await inst.getTime();
    Navigator.pushNamed(context, '/home', arguments: {
      'location': inst.location,
      'flag': inst.flag,
      'time': inst.time,
      'isday': inst.isday,
    });

    // print(inst.time);
    // setState(() {
    //   time = inst.time;
    // });
  }

  @override
  void initState() {
    super.initState();
    worldtime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
