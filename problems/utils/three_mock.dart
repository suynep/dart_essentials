import 'package:lorem_ipsum/lorem_ipsum.dart';
import "dart:math";

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

const int paragraphs = 1;
final int randomMinoWordInsertions = minorWords.length;

String generateMockSentence() {
  var para = loremIpsum(paragraphs: paragraphs);
  var splitPara = para.split(" ").map((e) => e.trim()).toList();

  for (int i = 0; i < randomMinoWordInsertions; i++) {
    int randomInsertionPosition = Random().nextInt(splitPara.length);
    splitPara.insert(
      randomInsertionPosition,
      minorWords[Random().nextInt(minorWords.length)],
    );
  }

  return splitPara.join(" ");
}
