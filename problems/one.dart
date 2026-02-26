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
  List<int> input = [];
  late final Map<String, dynamic> outputs = {};

  @override
  void getData() {
    bool valid = true;

    showBanner();

    do {
      input = [];
      valid = true;
      stdout.write("Enter comma-separated list of nums: ");
      String? userInput = stdin.readLineSync();
      userInput = userInput ?? ""; // handle potential nullability

      if (userInput.isEmpty) {
        print("Empty Input Detected!");
        valid = false;
      }

      if (userInput.contains(RegExp(r", *$"))) {
        print("Please remove any trailing commas");
        valid = false;
      }

      if (userInput.contains(RegExp(r"[0-9] +[0-9]"))) {
        print("Please enter in CSV format!");
        valid = false;
      }

      if (valid) {
        for (var ele in userInput.split(",").toList()) {
          int? numericEle = int.tryParse(ele.trim());
          if (numericEle == null) {
            valid = false;
            print("Non-numeric data detected!");
            break;
          }
          input.add(numericEle);
        }
      }
    } while (!valid);
  }

  /*
  1: Sum
  2: Average
  3: Minimum
  4: Maximum
  5: Odds
  6: Evens
  */

  void getComputationChoice() {
    print("""

1: Sum
2: Average
3: Minimum
4: Maximum
5: Odds
6: Evens
7: Ascending Sort
8: Descending Sort 

q: exit
""");

    bool valid = true;

    do {
      valid = true;
      stdout.write("Enter a choice: ");
      String? choiceInput = stdin.readLineSync();
      int integralInput = 0;

      if (choiceInput == null) {
        print("Invalid Choice Detected!");
        valid = false;
      } else {
        try {
          integralInput = int.parse(choiceInput.trim());
        } on FormatException {
          if (choiceInput.trim().toLowerCase() != "q") {
            print("Cannot Parse Choice");
            valid = false;
          } else {
            summaryBanner();
            break;
          }
        }
      }

      if (valid) {
        switch (integralInput) {
          case 1:
            display("Sum");
            valid = false;
            break;
          case 2:
            display("Average");
            valid = false;
            break;
          case 3:
            display("Minimum");
            valid = false;
            break;
          case 4:
            display("Maximum");
            valid = false;
            break;
          case 5:
            display("Odds");
            valid = false;
            break;
          case 6:
            display("Evens");
            valid = false;
            break;
          case 7:
            display("Ascending");
            valid = false;
            break;
          case 8:
            display("Descending");
            valid = false;
            break;
          default:
            print("Invalid Option");
            valid = false;
            break;
        }
      } else {
        print("Press `q` to exit");
        valid = false;
      }
    } while (!valid);
  }

  /// call this AFTER calling getData, as that initializes our late input instance var
  @override
  void wrangleAndCompute() {
    int sum = input.reduce((v, e) => v + e);
    double avg = sum / input.length;

    int minimum = input.reduce((v, e) {
      return min(v, e);
    });

    int maximum = input.reduce((v, e) {
      return max(v, e);
    });

    outputs["Sum"] = sum;
    outputs["Average"] = avg;
    outputs["Minimum"] = minimum;
    outputs["Maximum"] = maximum;

    List<num> evens = List.empty(growable: true);
    List<num> odds = List.empty(growable: true);

    for (var ele in input) {
      if (ele.isEven) {
        evens.add(ele);
      } else {
        odds.add(ele);
      }
    }

    outputs["Odds"] = odds;
    outputs["Evens"] = evens;

    //
    List<int> ascSortedInput = List.from(input);
    ascSortedInput.sort((a, b) => a.compareTo(b));

    List<int> descSortedInput = List.from(input);
    descSortedInput.sort((a, b) => b.compareTo(a));

    outputs["Ascending"] = ascSortedInput;
    outputs["Descending"] = descSortedInput;

    getComputationChoice();
  }

  /// Displays output; call after `ProblemOne.wrangleAndCompute()`.
  ///
  /// The optional parameter `key` can be provided to display specific output data.
  @override
  void display([String? key]) {
    if (key != null) {
      if (outputs.keys.contains(key)) {
        print("$key: ${outputs[key]}");
      } else {
        print("The key doesn't exist!");
      }
    } else {
      for (var k in outputs.keys) {
        print("$k: ${outputs[k]}");
      }
    }
  }
}

void showBanner() {
  print(r"""
                                     ▄▄     
                                    ██      
 ▄           ▄              ▄    ▀▀▄██▄     
 ████▄ ██ ██ ███▄███▄ ▄█▀█▄ ████▄██ ██ ██ ██
 ██ ██ ██ ██ ██ ██ ██ ██▄█▀ ██   ██ ██ ██▄██
▄██ ▀█▄▀██▀█▄██ ██ ▀█▄▀█▄▄▄▄█▀  ▄██▄██▄▄▀██▀
                                    ██   ██ 
                                   ▀▀  ▀▀▀  
""");
}

void summaryBanner() {
  print(r"""
             ▄        ▄              ▄         
 ▄██▀█ ██ ██ ███▄███▄ ███▄███▄ ▄▀▀█▄ ████▄██ ██
 ▀███▄ ██ ██ ██ ██ ██ ██ ██ ██ ▄█▀██ ██   ██▄██
█▄▄██▀▄▀██▀█▄██ ██ ▀█▄██ ██ ▀█▄▀█▄██▄█▀  ▄▄▀██▀
                                            ██ 
                                          ▀▀▀  
""");
}
