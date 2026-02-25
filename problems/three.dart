// ### Project 3: Text Analyzer
// Create a program that:
// - Takes a text input
// - Counts words, characters, sentences
// - Finds word frequency
// - Removes common words
// - Converts to uppercase/lowercase/title case

import 'dart:io';

import 'chooseable_problem.dart';

class ProblemThree implements IChooseableProblem {
  String input = "";
  Map<String, dynamic> output = Map();

  String convertToTitlecase(String data) {
    const minorWords = [
      "and",
      "but",
      "or",
      "a",
      "an",
      "the",
      "in",
      "on",
      "to",
      "is",
    ];

    var splitWords = data.split(" ");

    var titleCaseData = "";

    splitWords.asMap().forEach((index, word) {
      if (index == 0) {
        titleCaseData =
            "$titleCaseData ${word[0].toUpperCase()}${word.substring(1)}";
      } else if (!minorWords.contains(word) && word.length > 1) {
        titleCaseData =
            "$titleCaseData ${word[0].toUpperCase()}${word.substring(1)}";
      } else {
        titleCaseData = "$titleCaseData $word";
      }
    });

    return titleCaseData;
  }

  /// assume that words having frequency >= 2 are considered common
  Map<String, int> removeCommonWords(Map<String, int> frequencyMap) {
    Map<String, int> uniqueWords = {};

    frequencyMap.forEach((key, value) {
      if (!(value >= 2)) {
        uniqueWords.addEntries([MapEntry(key, value)]);
      }
    });

    return uniqueWords;
  }

  void getData() {
    stdout.write("Enter a sentence: ");
    String? _input = stdin.readLineSync();
    input = _input ?? "";
  }

  void wrangleAndCompute() {
    var words = input.split(" ");
    var chars = words.expand((e) => e.split("")).toList();
    var sentences = input
        .split(RegExp(r"[.?!]+"))
        .map((sentence) => sentence.trim())
        .toList();

    words = List<String>.from(words).map((word) {
      word = word.replaceAll(RegExp(r"[,.?!#@/\_-]+"), "");
      return word;
    }).toList();

    var wordsFrequency = Map<String, int>.fromIterables(
      Set.from(words),
      List.filled(Set.from(words).length, 0),
    );
    var charsFrequency = Map<String, int>.fromIterables(
      Set.from(chars),
      List.filled(Set.from(chars).length, 0),
    );

    words.forEach((word) {
      if (wordsFrequency.keys.contains(word)) {
        wordsFrequency[word] = wordsFrequency[word]! + 1;
      } else {
        wordsFrequency[word] = 1;
      }
    });

    chars.forEach((char) {
      if (charsFrequency.keys.contains(char)) {
        charsFrequency[char] = charsFrequency[char]! + 1;
      } else {
        charsFrequency[char] = 1;
      }
    });

    output["wordsFrequency"] = wordsFrequency;
    output["charsFrequency"] = charsFrequency;
    output["sentences"] = sentences;
    output["titleCaseSentences"] = sentences.map(convertToTitlecase).toList();
    output["upperCaseSentences"] = sentences
        .map((w) => w.toUpperCase())
        .toList();
    output["lowerCaseSentences"] = sentences
        .map((w) => w.toLowerCase())
        .toList();
    output["uniqueWords"] = removeCommonWords(wordsFrequency);
  }

  void display() {
    for (var entry in output.entries) {
      print("\n");
      {
        if (entry.value is Map) {
          print(entry.key);
          for (var subEntry in entry.value.entries) {
            print("${subEntry.key}: ${subEntry.value}");
          }
        } else {
          print("${entry.key}: ${entry.value}");
        }
      }
    }
  }
}
