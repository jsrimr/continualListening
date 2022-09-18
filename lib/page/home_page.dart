import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text_example/api/speech_api.dart';
import 'package:speech_to_text_example/main.dart';
import 'package:speech_to_text_example/widget/substring_highlighted.dart';

import '../my_provider.dart';
import '../utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isListening = false;
    // bool continueListening = Provider.of<Manage>(context).mode;
    String text = Provider.of<Manage>(context).text;
    int cnt = Provider.of<Manage>(context).cnt;

    final _speech = SpeechToText();
    final isAvailable = _speech.initialize(
      onStatus: (status) => _speech.isListening,
      onError: (e) => print('Error: $e'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(30).copyWith(bottom: 150),
        child: SubstringHighlight(
          text: cnt.toString() + ' ' + text,
          terms: Command.all,
          textStyle: TextStyle(
            fontSize: 32.0,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textStyleHighlight: TextStyle(
            fontSize: 32.0,
            color: Colors.red,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              Provider.of<Manage>(context, listen: false).increment();



              // bool continueListening = Provider.of<Manage>(context).mode;
              while (true) {
                if (isAvailable != null) {
                  _speech.listen(
                    onResult: (value) {
                    Provider.of<Manage>(context, listen: false)
                        .setSpeechText(value.recognizedWords);
                    print('${value.recognizedWords} and provider value : ${text}');
                    if (value.recognizedWords.contains('stop')) {
                      Provider.of<Manage>(context, listen: false).changeMode(false);
                      _speech.stop();
                    }
                  },
                  partialResults: true,
                  listenFor: Duration(seconds: 30),
                  );
                }
                // continueListening = Provider.of<Manage>(context).mode;
                //wait for 1 second
                Future.delayed(Duration(seconds: 10));
              }
            },
            child: Icon(isListening ? Icons.mic : Icons.mic_none),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              _speech.stop();
              // continueListening = false;
              // Provider.of<Manage>(context, listen: false).changeMode(false);
            },
            child: Icon(Icons.stop),
          ),
        ],
      ),
    );
  }
}
