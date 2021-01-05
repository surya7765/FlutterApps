import 'dart:async';
import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      highContrastDarkTheme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/googleservice.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  final messageInsert = TextEditingController();

  List<Map> messages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        brightness: Brightness.dark,
        title: Column(
          children: [
            Text(
              "AI Chat Bot",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: StreamBuilder<DateTime>(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                      DateFormat('yyyy, hh:mm:ss').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(),
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => chat(
                      messages[index]["message"].toString(),
                      messages[index]["data"]),
                ),
              ),
              Container(
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions_rounded,
                      color: Colors.pinkAccent,
                      size: 30.0,
                    ),
                  ),
                  title: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white12,
                    ),
                    padding: EdgeInsets.only(left: 15.0),
                    child: TextFormField(
                      controller: messageInsert,
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText: "Type message",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.pinkAccent,
                      size: 30,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("something");
                      } else {
                        messages.insert(
                            0, {"data": 1, "message": messageInsert.text});
                        response(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode curFocus = FocusScope.of(context);
                      if (!curFocus.hasPrimaryFocus) {
                        curFocus.unfocus();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          data == 0
              ? Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.iwmbuzz.com/wp-content/uploads/2019/08/the-rise-of-rapper-raftaar-on-the-indian-music-scene-920x518.jpg'),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Bubble(
              radius: Radius.circular(15.0),
              color: data == 0 ? Colors.grey : Colors.pinkAccent[100],
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          data == 1
              ? Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn.vox-cdn.com/thumbor/nDW7YqKV8soKsZSfRorGXJLSH50=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/22147179/1229892934.jpg'),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
