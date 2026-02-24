// ### Project 1: Number List Analyzer
// Create a program that:
// - Takes a list of numbers as input
// - Calculates sum, average, min, max
// - Filters odd/even numbers
// - Sorts in ascending/descending order
// - Removes duplicates

import 'chooseable_problem.dart';
import "dart:io";
import "dart:math";

class ProblemOne implements IChooseableProblem {
  late final List<int> input;
  late final Map<String, dynamic> outputs = Map();

  ProblemOne();

  void getData() {
    stdout.write("Enter comma-separated list of nums: ");
    String? userInput = stdin.readLineSync();
    userInput = userInput ?? ""; // handle potential nullability

    input = userInput.split(",").toList().map((ele) {
      var numericEle = int.tryParse(ele.trim()) ?? 0;
      return numericEle;
    }).toList();
  }

  /// call this AFTER calling getData, as that initializes out late input instance var
  void wrangleAndCompute() {
    int sum = input.reduce((v, e) => v + e);
    double avg = sum / input.length;

    int _min = input.reduce((v, e) {
      return min(v, e);
    });

    int _max = input.reduce((v, e) {
      return max(v, e);
    });

    outputs["Sum"] = sum;
    outputs["Average"] = avg;
    outputs["Minimum"] = _min;
    outputs["Maximum"] = _max;

    List<num> evens = List.empty(growable: true);
    List<num> odds = List.empty(growable: true);

    input.forEach((ele) {
      if (ele.isEven)
        evens.add(ele);
      else
        odds.add(ele);
    });

    outputs["Odds"] = odds;
    outputs["Evens"] = evens;

    List<int> ascSortedInput = List.from(input);
    ascSortedInput.sort((a, b) => a.compareTo(b));

    List<int> descSortedInput = List.from(input);
    descSortedInput.sort((a, b) => b.compareTo(a));

    outputs["Ascending"] = ascSortedInput;
    outputs["Descending"] = descSortedInput;
  }

  /// Displays output; call after wrangleAndCompute
  void display() {
    for (var k in outputs.keys) {
      print("$k: ${outputs[k]}");
    }
  }
}
