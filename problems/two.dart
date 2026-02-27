// ### Project 2: Student Grade Manager
// Create a program using Maps that:
// - Stores student names and grades
// - Adds/removes/updates students
// - Calculates class average
// - Finds top performers
// - Filters students by grade range

import 'chooseable_problem.dart';
import "dart:io";

import "utils/two_mock.dart";

/// Descending Ordered grade enums
enum Grade { aPlus, A, bPlus, B, cPlus, C, dPlus, D, F }

class ProblemTwo implements IChooseableProblem {
  static int globalId = 0;

  Map<int, Map<String, dynamic>> studentsData = {};

  void showAvailableGrades() {
    print("Available Grades:");
    print("A+ A B+ B C+ C D+ D F");
  }

  Grade stringToEnum(String grade) {
    Grade gradeEnum = Grade.F;
    switch (grade.trim().toLowerCase()) {
      case "a+":
        gradeEnum = Grade.aPlus;
        break;
      case "a":
        gradeEnum = Grade.A;
        break;
      case "b+":
        gradeEnum = Grade.bPlus;
        break;
      case "b":
        gradeEnum = Grade.B;
        break;
      case "c+":
        gradeEnum = Grade.cPlus;
        break;
      case "c":
        gradeEnum = Grade.C;
        break;
      case "d+":
        gradeEnum = Grade.dPlus;
        break;
      case "d":
        gradeEnum = Grade.D;
        break;
      case "f":
        gradeEnum = Grade.F;
        break;
    }

    return gradeEnum;
  }

  @override
  void getData() {
    bool continueNext = true;

    showBanner();

    // this is going to be SO redundant, it makes me cry

    stdout.write("Use Mock Students Data? (y/n) ");
    String mockInputCheck = stdin.readLineSync() ?? "";

    if (mockInputCheck.trim().toLowerCase() == "y") {
      continueNext = false;
      var inputs = generateMockStudentData();

      inputs.forEach((k, v) {
        Grade? gradeEnum;

        switch (v.toLowerCase()) {
          case "a+":
            gradeEnum = Grade.aPlus;
            break;
          case "a":
            gradeEnum = Grade.A;
            break;
          case "b+":
            gradeEnum = Grade.bPlus;
            break;
          case "b":
            gradeEnum = Grade.B;
            break;
          case "c+":
            gradeEnum = Grade.cPlus;
            break;
          case "c":
            gradeEnum = Grade.C;
            break;
          case "d+":
            gradeEnum = Grade.dPlus;
            break;
          case "d":
            gradeEnum = Grade.D;
            break;
          case "f":
            gradeEnum = Grade.F;
            break;
        }

        studentsData[globalId] = {"name": k, "grade": gradeEnum!};
        globalId++;
      });
    }

    while (continueNext) {
      stdout.write("\npress `q` to stop input sequence\n");
      showAvailableGrades();
      sleep(Duration(milliseconds: 500));
      stdout.write("\nEnter Comma-separated Name, Grade pair: ");
      var input = stdin.readLineSync() ?? "";

      if (input.trim().toLowerCase() == "q") {
        break;
      }

      try {
        var [student, grade] = input.split(",").map((e) => e.trim()).toList();
        Grade gradeEnum = stringToEnum(grade);

        studentsData[globalId] = {
          "name": student,
          "grade": gradeEnum,
        }; // for the time being, revert to F
        globalId++;
      } catch (e) {
        print("\nError: $e");
      }
    }
  }

  void displayChoices() {
    stdout.write("""

1: remove student by id
2: update existing student by id
3: calculate class average
4: find top performer(s)
5: filter by grade range <grade_1, grade_2>
6: add new student
q: quit

""");
  }

  @override
  void wrangleAndCompute() {
    bool continueNext = true;

    while (continueNext) {
      PrettyPrint().printTable(studentsData, titles: ["id", "name", "grade"]);
      displayChoices();
      stdout.write("\nEnter choice: ");
      var input = stdin.readLineSync();
      input = input ?? "";

      if (input.trim().toLowerCase() == "q") {
        break;
      }

      switch (input.trim()) {
        case "6":
          showAvailableGrades();
          sleep(Duration(milliseconds: 500));
          stdout.write("\nEnter Comma-separated Name, Grade pair: ");
          var input = stdin.readLineSync() ?? "";

          if (input.trim().toLowerCase() == "q") {
            break;
          }

          try {
            var [student, grade] = input
                .split(",")
                .map((e) => e.trim())
                .toList();
            Grade gradeEnum = stringToEnum(grade);

            studentsData[globalId] = {
              "name": student,
              "grade": gradeEnum,
            }; // for the time being, revert to F
            globalId++;
          } catch (e) {
            print("\nError: $e");
          }
          break;

        case "1":
          if (studentsData.isNotEmpty) {
            stdout.write("\nEnter ID: ");
            var innerInput = stdin.readLineSync();
            innerInput = innerInput ?? "";
            innerInput = innerInput.trim();

            try {
              int innerInputAsInt = int.parse(innerInput);
              var justRemoved = studentsData.remove(innerInputAsInt);
              if (justRemoved == null) {
                print("Student not found!");
              } else {
                print("Removed: ");
                PrettyPrint().printTable(
                  {innerInputAsInt: justRemoved},
                  titles: ["id", "name", "grade"],
                );
              }
            } on FormatException {
              print("Cannot parse id!");
            }
          } else {
            print("Cannot perform on empty data");
          }
          break;
        case "2":
          if (studentsData.isNotEmpty) {
            stdout.write("Enter ID: ");
            var innerInput = stdin.readLineSync();
            innerInput = innerInput ?? "";
            innerInput = innerInput.trim();

            try {
              int innerInputAsInt = int.parse(innerInput);
              try {
                stdout.write("\nEnter name, grade (csv): ");
                var innerInput = stdin.readLineSync();
                innerInput = innerInput ?? "";

                var [student, grade] = innerInput
                    .split(",")
                    .map((ele) => ele.trim())
                    .toList();

                if (studentsData.containsKey(innerInputAsInt)) {
                  Grade gradeEnum = stringToEnum(grade);

                  studentsData[innerInputAsInt] = {
                    "name": student,
                    "grade": gradeEnum,
                  }; // fallback as Grade.F
                } else {
                  print("\nStudent Not Found, try again!");
                }
              } catch (e) {
                print("\nStudent not found: $e");
              }
            } on FormatException {
              print("Cannot parse id!");
            }
          } else {
            print("Cannot perform on empty data");
          }

          break;
        case "3":
          if (studentsData.isNotEmpty) {
            var total = 0;
            for (var entry in studentsData.values) {
              total += (entry["grade"] as Grade).index;
            }

            int avg = total ~/ studentsData.values.length;

            Grade avgGrade = Grade.values[avg];

            print("\nAverage Grade: $avgGrade");
            sleep(Duration(milliseconds: 500));
          } else {
            print("Cannot perform on empty data");
          }
          break;

        case "4":
          if (studentsData.isNotEmpty) {
            var minimum = studentsData.values.reduce((v, e) {
              return v["grade"].index > e["grade"].index ? e : v;
            });

            print("\nTop Performers: ");
            sleep(Duration(milliseconds: 500));
            Map<int, Map<String, dynamic>> topPerformers = {};
            studentsData.forEach((key, value) {
              if (value == minimum) {
                topPerformers[key] = value;
              }
            });

            PrettyPrint().printTable(
              topPerformers,
              titles: ["id", "name", "grade"],
            );
          } else {
            print("Cannot perform on empty data");
          }
          break;

        case "5":
          if (studentsData.isNotEmpty) {
            stdout.write("\nEnter grade range in csv form: ");
            String? innerInput = stdin.readLineSync();
            innerInput = innerInput ?? "";

            var [gradeOne, gradeTwo] = innerInput
                .split(",")
                .map((ele) => ele.trim())
                .toList();

            Grade gradeOneEnum = stringToEnum(gradeOne);

            Grade gradeTwoEnum = stringToEnum(gradeTwo);

            gradeOneEnum = gradeOneEnum;
            gradeTwoEnum = gradeTwoEnum;
            Map<int, Map<String, dynamic>> rangeData = {};

            // grab the grades in the range, inclusive of both
            studentsData.forEach((k, v) {
              if (v["grade"].index >= gradeOneEnum.index &&
                  v["grade"].index <= gradeTwoEnum.index) {
                rangeData[k] = v;
              }
            });

            PrettyPrint().printTable(
              rangeData,
              titles: ["id", "name", "grade"],
            );
            sleep(Duration(milliseconds: 500));
          } else {
            print("Cannot perform on empty data");
          }

          break;
      }
    }
  }

  @override
  void display() {
    print("Final Records:\n");
    PrettyPrint().printTable(studentsData, titles: ["id", "name", "grade"]);
    print("\n");
    print("Exited Successfully.");
  }
}

class PrettyPrint {
  void printTable(
    dynamic records, {
    required List<String> titles,
    int columnSize = 25,
  }) {
    void printHeader() {
      for (int i = 0; i < 3; i++) {
        switch (i) {
          case 0:
            String borderString = "+";
            for (var _ in titles) {
              borderString += "${"-" * columnSize}+";
            }
            print(borderString);

          case 1:
            String titleString = "|";
            for (var t in titles) {
              titleString += "${t.padRight(columnSize)}|";
            }
            print(titleString);

          case 2:
            String borderString = "+";
            for (var _ in titles) {
              borderString += "${"-" * columnSize}+";
            }
            print(borderString);
        }
      }
    }

    void printBody() {
      if (records is List) {
        for (int i = 0; i < records.length; i++) {
          String rowString = "|";
          for (var ele in records[i]) {
            rowString += "${ele.toString().padRight(columnSize)}|";
          }
          print(rowString);
        }
      } else if (records is Map) {
        // presently, this is tailored for THIS use case ONLY, not a generic handler
        for (var i in records.keys) {
          String rowString = "|${i.toString().padRight(columnSize)}|";
          for (var key in records[i].keys) {
            String recordData =
                records[i][key].toString().padRight(columnSize).length >
                    columnSize
                ? records[i][key]
                      .toString()
                      .padRight(columnSize)
                      .substring(0, columnSize)
                : records[i][key].toString().padRight(columnSize);
            if (records[i][key] is double) {
              recordData = records[i][key]
                  .toStringAsFixed(2)
                  .padRight(columnSize);
            }
            rowString += "$recordData|";
          }
          print(rowString);
        }
      }
    }

    void printTrailer() {
      String borderString = "+";
      for (var _ in titles) {
        borderString += "${"-" * columnSize}+";
      }
      print(borderString);
    }

    printHeader();
    printBody();
    printTrailer();
  }
}
