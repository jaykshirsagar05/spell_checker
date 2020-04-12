import 'package:cloud_firestore/cloud_firestore.dart';
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
  int totalWords = 0;
  int score = 0;
  int counter = 0;
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
    super.initState();
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

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }
  //Method to get total words.
  Future _getTotalWords () async{
    var word = await Firestore.instance.collection('/words').document('grade_1').get();
    var answer = word['level_1'];
    totalWords = answer.length;
    words = answer;

  }
  Future _getWord () async {
    //var word = await Firestore.instance.collection('/words').document('grade_1').get();
    //var answer = word['level_1'];
    //que.speak_word(answer[counter]);
    if(counter<=totalWords){
      _onChange(words[counter]);
      _speak();
      counter++;
    }
  }

  bool _checkAnswer (String s) {
    bool flag;
    if(_newVoiceText == s){ 
      score++;
      flag = true;
      Fluttertoast.showToast(msg: 'Correct!!!');
      }
    else {
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
    score = 0;
  }


  Widget build(BuildContext context) {
    _getTotalWords();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Practice')),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("First Press below button then type answer"),
            IconButton(icon: Icon(Icons.hearing),iconSize: 50, onPressed: () async {
                _getWord();
              }),

            TextField(
              decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter answer',
              fillColor: Colors.blue,
              ),
              
              onSubmitted: (text) {
                setState(() {
                  var result = _checkAnswer(text);
                  print(result);
                  TextEditingController().text = "";
                });
              },
              controller: TextEditingController(),
              
            ),
            Text(counter.toString() + '/' + totalWords.toString()),
            RaisedButton(
              child: Text('End Game'),
              onPressed: () {
                bloc.updateScore(score);
                Navigator.of(context).pushReplacementNamed('/dashboard');
              },
            )
          ],
        )
      ),
    );
  }
}