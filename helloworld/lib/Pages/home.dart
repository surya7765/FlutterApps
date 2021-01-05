import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // print(data);

    String bgimage = data['isday']
        ? 'https://upload.wikimedia.org/wikipedia/commons/e/e7/Sky_with_puffy_clouds.JPG'
        : 'https://pixy.org/download/3754598/';

    Color bgcolor = data['isday'] ? Colors.blue : Colors.black;
    return Scaffold(
        backgroundColor: bgcolor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(bgimage),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 60.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isday': result['isday'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[700],
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    color: Colors.indigo,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
