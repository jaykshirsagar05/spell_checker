import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spell_check/services/bloc.dart' as bloc;

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

enum TtsState { playing, stopped }

class _GameState extends State<Game> {
  var words;
  int score;
  int counter;
  bool text_pressed = true, skip_pressed = true;
  List<DataRow> _rowList = [];
  //tts variables
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;
  String _newVoiceText;
  //Text-to-speech setup.
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;
  @override
  initState() {
    score = 0;
    counter = 0;
    words = [];
    super.initState();
    bloc.setTotalWords();
    words = bloc.getTotalWords();
    print(words);
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  void _addRow(String a, String b, bool c) {
    // Built in Flutter Method.
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below.
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(Text(a)),
        DataCell(Text(b)),
        DataCell(Text(c.toString())),
      ]));
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  Future _getWord() async {
    if (counter <= words.length) {
      _onChange(words[counter]);
      while (text_pressed && skip_pressed) {
        for (var i = 0; i < 3; i++) {
          await _speak();
          sleep(Duration(seconds: 1));
        }
      }
      text_pressed = true;
      skip_pressed = true;
      counter++;
    }
  }

  bool _checkAnswer(String s) {
    bool flag;
    if (_newVoiceText == s) {
      score++;
      flag = true;
      Fluttertoast.showToast(msg: 'Correct!!!');
    } else {
      flag = false;
      Fluttertoast.showToast(msg: 'Wrong!!!');
    }
    return flag;
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    counter = 0;
    bloc.removeTotalWords();
  }

  Widget build(BuildContext context) {
    print(words.length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Practice')),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("First Press below button then type answer"),
            IconButton(
                icon: Icon(Icons.hearing),
                iconSize: 50,
                onPressed: () async {
                  _getWord();
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintText: 'Enter answer',
                  fillColor: Colors.blue,
                ),
                onTap: () {
                  text_pressed = false;
                },
                onSubmitted: (text) {
                  setState(() {
                    var result = _checkAnswer(text.toLowerCase());
                    _addRow(_newVoiceText, text, result);
                    print(result);
                    //_userText = text;
                    TextEditingController().text = "";
                  });
                },
                controller: TextEditingController(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Skip'),
                    splashColor: Colors.blue,
                    onPressed: () {
                      bloc.addToSkipped(_newVoiceText);
                      skip_pressed = false;
                      _addRow(_newVoiceText, "-", null);
                    },
                  ),
                ),
              ],
            ),
            Text(counter.toString() + '/' + words.length.toString()),
            DataTable(columns: [
              DataColumn(label: Text('Word')),
              DataColumn(label: Text('Your Answer')),
              DataColumn(label: Text('Result')),
            ], rows: _rowList),
            RaisedButton(
              child: Text('End Game'),
              onPressed: ()  {
                if(ttsState == TtsState.stopped){
                  print(score);
                  bloc.updateScore(score);
                 Navigator.of(context).pushReplacementNamed('/dashboard');
                }
                
              },
            )
          ],
        ),
      )),
    );
  }
}
