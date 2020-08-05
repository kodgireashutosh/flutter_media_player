import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(
      new MaterialApp(debugShowCheckedModeBanner: false, home: LocalAudio()));
}

class LocalAudio extends StatefulWidget {
  @override
  _LocalAudio createState() => _LocalAudio();
}

class _LocalAudio extends State<LocalAudio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    // ignore: deprecated_member_use
    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    // ignore: deprecated_member_use
    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0x46000000),
                offset: Offset(0, 20),
                spreadRadius: 0,
                blurRadius: 30,
              ),
              BoxShadow(
                color: Color(0x11000000),
                offset: Offset(0, 10),
                spreadRadius: 0,
                blurRadius: 30,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage("https://exelosys.com/myimg.jpg"),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          "Demo Music",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text("Demo 12:50"),
        Container(
          child: Row(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(2.0)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
      minWidth: 48.0,
      child: Container(
        width: 75,
        height: 45,
        child: RaisedButton(
            elevation: 10.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Text(txt),
            color: Colors.purple.shade400,
            textColor: Colors.white,
            onPressed: onPressed),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LocalAudio() {
    return _tab([
      _btn('Play', () => audioCache.play('mymusic.mp3')),
      SizedBox(
        height: 10.0,
      ),
      _btn('Pause', () => advancedPlayer.pause()),
      SizedBox(
        height: 10.0,
      ),
      _btn('Stop', () => advancedPlayer.stop()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.purple,
          title: Text("Audio Player"),
        ),
        body: TabBarView(
          children: [LocalAudio()],
        ),
      ),
    );
  }
}
