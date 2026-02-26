// ### Project 3: Text Analyzer
// Create a program that:
// - Takes a text input
// - Counts words, characters, sentences
// - Finds word frequency
// - Removes common words
// - Converts to uppercase/lowercase/title case

import 'dart:io';

import 'chooseable_problem.dart';
import 'utils/three_mock.dart';

class ProblemThree implements IChooseableProblem {
  String input = "";
  Map<String, dynamic> output = {};
  bool useMockData = false;

  String convertToTitlecase(String data) {
    var splitWords = data.split(" ");

    var titleCaseData = "";

    splitWords.asMap().forEach((index, word) {
      if (word.isNotEmpty) {
        if (index == 0) {
          titleCaseData =
              "$titleCaseData ${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
        } else if (!minorWords.contains(word.toLowerCase()) &&
            word.length > 1) {
          titleCaseData =
              "$titleCaseData ${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
        } else if (minorWords.contains(word.toLowerCase())) {
          titleCaseData = "$titleCaseData ${word.toLowerCase()}";
        } else {
          titleCaseData = "$titleCaseData $word";
        }
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

  @override
  void getData() {
    stdout.write("Use mock data? (y/n) ");
    String mockDataInput = stdin.readLineSync() ?? "";

    if (mockDataInput.trim().toLowerCase() == "y") {
      useMockData = true;
      input = generateMockSentence();
    } else {
      useMockData = false;
      stdout.write("Enter a sentence: ");
      String localInput = stdin.readLineSync() ?? "";
      input = localInput;
    }
  }

  @override
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

    for (var word in words) {
      if (wordsFrequency.keys.contains(word)) {
        wordsFrequency[word] = wordsFrequency[word]! + 1;
      } else {
        wordsFrequency[word] = 1;
      }
    }

    for (var char in chars) {
      if (charsFrequency.keys.contains(char)) {
        charsFrequency[char] = charsFrequency[char]! + 1;
      } else {
        charsFrequency[char] = 1;
      }
    }

    output["wordsFrequency"] = wordsFrequency;
    output["uniqueWords"] = removeCommonWords(wordsFrequency);
    output["charsFrequency"] = charsFrequency;
    output["sentences"] = sentences;
    output["titleCaseSentences"] = sentences.map(convertToTitlecase).toList();
    output["upperCaseSentences"] = sentences
        .map((w) => w.toUpperCase())
        .toList();
    output["lowerCaseSentences"] = sentences
        .map((w) => w.toLowerCase())
        .toList();
  }

  @override
  void display() {
    int wordFieldLength = 20;
    int wordsPerLine = 7;
    int charFieldLength = 10;
    int charsPerLine = 14;

    for (var entry in output.entries) {
      {
        if (entry.value is Map) {
          switch (entry.key) {
            case "wordsFrequency":
              categoryBanner("words");
              String wordsFrequencyString = "";
              int count = 0;
              for (var subEntry in entry.value.entries) {
                if (subEntry.key == "\n") {
                  wordsFrequencyString +=
                      r"\n" + "${subEntry.value}".padRight(wordFieldLength);
                } else {
                  wordsFrequencyString += "${subEntry.key} ${subEntry.value}"
                      .padRight(wordFieldLength);
                }
                count += 1;
                if (count == wordsPerLine) {
                  wordsFrequencyString += "\n";
                  count = 0;
                }
              }
              wordsFrequencyString += "\n";
              print(wordsFrequencyString);
              break;
            case "uniqueWords":
              categoryBanner("unique");
              String wordsFrequencyString = "";
              int count = 0;
              for (var subEntry in entry.value.entries) {
                if (subEntry.key == "\n") {
                  wordsFrequencyString +=
                      r"\n" + "${subEntry.value}".padRight(wordFieldLength);
                } else {
                  wordsFrequencyString += "${subEntry.key} ${subEntry.value}"
                      .padRight(wordFieldLength);
                }
                count += 1;
                if (count == wordsPerLine) {
                  wordsFrequencyString += "\n";
                  count = 0;
                }
              }
              wordsFrequencyString += "\n";
              print(wordsFrequencyString);
              break;
            case "charsFrequency":
              categoryBanner("chars");
              String charsFrequencyString = "";
              int count = 0;
              for (var subEntry in entry.value.entries) {
                if (subEntry.key == "\n") {
                  charsFrequencyString +=
                      r"\n" + "${subEntry.value}".padRight(charFieldLength);
                } else {
                  charsFrequencyString += "${subEntry.key} ${subEntry.value}"
                      .padRight(charFieldLength);
                }
                count += 1;
                if (count == charsPerLine) {
                  charsFrequencyString += "\n";
                  count = 0;
                }
              }
              charsFrequencyString += "\n";
              print(charsFrequencyString);
              break;
          }
        } else {
          switch (entry.key) {
            case "upperCaseSentences":
              categoryBanner("upperCase");
              break;

            case "lowerCaseSentences":
              categoryBanner("lowerCase");
              break;

            case "sentences":
              categoryBanner("sentences");
              break;

            case "titleCaseSentences":
              categoryBanner("titleCase");
              break;
          }
          print(entry.value.join(" "));
        }
      }
    }
  }
}

void categoryBanner(String category) {
  switch (category) {
    case "words":
      print(r"""
                        █▄      
                ▄       ██      
▀█▄ █▄ ██▀▄███▄ ████▄▄████ ▄██▀█
 ██▄██▄██ ██ ██ ██   ██ ██ ▀███▄
  ▀██▀██▀▄▀███▀▄█▀  ▄█▀████▄▄██▀
""");
      break;
    case "chars":
      print(r"""
       █▄                    
       ██          ▄         
 ▄███▀ ████▄ ▄▀▀█▄ ████▄▄██▀█
 ██    ██ ██ ▄█▀██ ██   ▀███▄
▄▀███▄▄██ ██▄▀█▄██▄█▀  █▄▄██▀

""");
      break;
    case "unique":
      print(r"""
       ▄     ▀▀                  
 ██ ██ ████▄ ██ ▄████ ██ ██ ▄█▀█▄
 ██ ██ ██ ██ ██ ██ ██ ██ ██ ██▄█▀
▄▀██▀█▄██ ▀█▄██▄▀████▄▀██▀█▄▀█▄▄▄
                   ██            
                    ▀            
""");
      break;

    case "sentences":
      print("""
                   █▄                              
             ▄    ▄██▄      ▄                      
 ▄██▀█ ▄█▀█▄ ████▄ ██ ▄█▀█▄ ████▄ ▄███▀ ▄█▀█▄ ▄██▀█
 ▀███▄ ██▄█▀ ██ ██ ██ ██▄█▀ ██ ██ ██    ██▄█▀ ▀███▄
█▄▄██▀▄▀█▄▄▄▄██ ▀█▄██▄▀█▄▄▄▄██ ▀█▄▀███▄▄▀█▄▄▄█▄▄██▀
""");
      break;

    case "lowerCase":
      print("""
 ▄▄                                                   
  ██                                                  
  ██                      ▄                           
  ██ ▄███▄▀█▄ █▄ ██▀▄█▀█▄ ████▄▄███▀ ▄▀▀█▄ ▄██▀█ ▄█▀█▄
  ██ ██ ██ ██▄██▄██ ██▄█▀ ██   ██    ▄█▀██ ▀███▄ ██▄█▀
 ▄██▄▀███▀  ▀██▀██▀▄▀█▄▄▄▄█▀  ▄▀███▄▄▀█▄███▄▄██▀▄▀█▄▄▄
""");
      break;

    case "upperCase":
      print("""
                         ▄                           
 ██ ██ ████▄ ████▄ ▄█▀█▄ ████▄▄███▀ ▄▀▀█▄ ▄██▀█ ▄█▀█▄
 ██ ██ ██ ██ ██ ██ ██▄█▀ ██   ██    ▄█▀██ ▀███▄ ██▄█▀
▄▀██▀█▄████▀▄████▀▄▀█▄▄▄▄█▀  ▄▀███▄▄▀█▄███▄▄██▀▄▀█▄▄▄
       ██    ██                                      
       ▀     ▀                                       
""");
      break;

    case "titleCase":
      print("""
         ▄▄                               
 █▄    █▄ ██                              
▄██▄▀▀▄██▄██                              
 ██ ██ ██ ██ ▄█▀█▄ ▄███▀ ▄▀▀█▄ ▄██▀█ ▄█▀█▄
 ██ ██ ██ ██ ██▄█▀ ██    ▄█▀██ ▀███▄ ██▄█▀
▄██▄██▄██▄██▄▀█▄▄▄▄▀███▄▄▀█▄███▄▄██▀▄▀█▄▄▄
""");
      break;
  }
}

// void printTable(
//   dynamic records, {
//   required List<String> titles,
//   int columnSize = 50,
// }) {
//   void printHeader() {
//     for (int i = 0; i < 3; i++) {
//       switch (i) {
//         case 0:
//           String borderString = "+";
//           for (var _ in titles) {
//             borderString += "${"-" * columnSize}+";
//           }
//           print(borderString);

//         case 1:
//           String titleString = "|";
//           for (var t in titles) {
//             titleString += "${t.padRight(columnSize)}|";
//           }
//           print(titleString);

//         case 2:
//           String borderString = "+";
//           for (var _ in titles) {
//             borderString += "${"-" * columnSize}+";
//           }
//           print(borderString);
//       }
//     }
//   }

//   void printBody() {
//     if (records is List) {
//       for (int i = 0; i < records.length; i++) {
//         String rowString = "|";
//         for (var ele in records[i]) {
//           rowString += "${ele.toString().padRight(columnSize)}|";
//         }
//         print(rowString);
//       }
//     }
//   }

//   void printTrailer() {
//     String borderString = "+";
//     for (var _ in titles) {
//       borderString += "${"-" * columnSize}+";
//     }
//     print(borderString);
//   }

//   printHeader();
//   printBody();
//   printTrailer();
// }
