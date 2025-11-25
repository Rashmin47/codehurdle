import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:english_words/english_words.dart' as words;

import 'codele.dart';

class HurdleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];

  List<Codele> hurdleBoard = [];

  String targetWord = '';
  int count = 0;
  int index = 0;
  final lettersPerRow = 5;

  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  generateBoard() {
    hurdleBoard = List.generate(30, (index) => Codele(letter: ''));
  }

  generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);
  }

  bool get isAValidWord => totalWords.contains(rowInputs.join('').toLowerCase());


  inputLetter(String letter) {
    if (count < lettersPerRow) {
      count++;
      rowInputs.add(letter);
      hurdleBoard[index] = Codele(letter: letter);
      index++;
      print(rowInputs);
      notifyListeners();
    }

  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);
    }
    if (count > 0){
      hurdleBoard[index - 1] = Codele(letter: '');
      count--;
      index--;
    }
    notifyListeners();

  }

}




