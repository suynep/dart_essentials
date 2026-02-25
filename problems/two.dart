// ### Project 2: Student Grade Manager
// Create a program using Maps that:
// - Stores student names and grades
// - Adds/removes/updates students
// - Calculates class average
// - Finds top performers
// - Filters students by grade range

import 'chooseable_problem.dart';
import "dart:io";
import "dart:math";

import "utils/two_mock.dart";

void display(Map<String, Grade> studentsData) {
  const nameFieldLength = 40;
  const gradeFieldLength = 40;

  print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");
  print(
    "|${"name".padRight(nameFieldLength)}|${"grade".padRight(gradeFieldLength)}|",
  );
  print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");

  studentsData.forEach((key, value) {
    print(
      "|${key.padRight(nameFieldLength)}|${value.name.padRight(gradeFieldLength)}|",
    );
  });

  print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");
}

/// Descending Ordered grade enums
enum Grade { APlus, A, BPlus, B, CPlus, C, DPlus, D, F }

class ProblemTwo implements IChooseableProblem {
  Map<String, Grade> studentsData = Map();

  void getData() {
    bool _continue = true;

    // this is going to be SO redundant, it makes me cry

    stdout.write("Use Mock Students Data? (y/n) ");
    String _mockInput = stdin.readLineSync() ?? "";

    if (_mockInput.trim().toLowerCase() == "y") {
      _continue = false;
      var inputs = generateMockStudentData();

      studentsData = inputs.map((k, v) {
        Grade? gradeEnum;

        switch (v.toLowerCase()) {
          case "a+":
            gradeEnum = Grade.APlus;
            break;
          case "a":
            gradeEnum = Grade.A;
            break;
          case "b+":
            gradeEnum = Grade.BPlus;
            break;
          case "b":
            gradeEnum = Grade.B;
            break;
          case "c+":
            gradeEnum = Grade.CPlus;
            break;
          case "c":
            gradeEnum = Grade.C;
            break;
          case "d+":
            gradeEnum = Grade.DPlus;
            break;
          case "d":
            gradeEnum = Grade.D;
            break;
          case "f":
            gradeEnum = Grade.F;
            break;
        }

        return MapEntry(k, gradeEnum!);
      });
    }

    while (_continue) {
      stdout.write("\npress `q` to stop input sequence\n");
      sleep(Duration(milliseconds: 500));
      stdout.write("\nEnter Comma-separated Name, Grade pair: ");
      var input = stdin.readLineSync() ?? "";

      if (input.trim().toLowerCase() == "q") {
        break;
      }

      try {
        var [student, grade] = input.split(",").map((e) => e.trim()).toList();
        grade = grade.toLowerCase();
        Grade? gradeEnum;

        switch (grade) {
          case "a+":
            gradeEnum = Grade.APlus;
            break;
          case "a":
            gradeEnum = Grade.A;
            break;
          case "b+":
            gradeEnum = Grade.BPlus;
            break;
          case "b":
            gradeEnum = Grade.B;
            break;
          case "c+":
            gradeEnum = Grade.CPlus;
            break;
          case "c":
            gradeEnum = Grade.C;
            break;
          case "d+":
            gradeEnum = Grade.DPlus;
            break;
          case "d":
            gradeEnum = Grade.D;
            break;
          case "f":
            gradeEnum = Grade.F;
            break;
        }

        studentsData[student] =
            gradeEnum ?? Grade.F; // for the time being, revert to F
      } catch (e) {
        print("\nError: $e");
      }
    }
  }

  void wrangleAndCompute() {
    void printStudents(Map<String, Grade> _studentsData) {
      const nameFieldLength = 40;
      const gradeFieldLength = 40;

      print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");
      print(
        "|${"name".padRight(nameFieldLength)}|${"grade".padRight(gradeFieldLength)}|",
      );
      print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");

      _studentsData.forEach((key, value) {
        print(
          "|${key.padRight(nameFieldLength)}|${value.name.padRight(gradeFieldLength)}|",
        );
      });

      print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");
    }

    bool _continue = true;

    stdout.write("""

1: remove student
2: update existing student by name
3: calculate class average
4: find top performer(s)
5: filter by grade range <grade_1, grade_2>
q: quit

""");

    while (_continue) {
      printStudents(studentsData);
      stdout.write("\nEnter choice: ");
      var input = stdin.readLineSync();
      input = input ?? "";

      if (input.trim().toLowerCase() == "q") {
        break;
      }

      switch (input.trim()) {
        case "1":
          stdout.write("\nEnter name: ");
          var _input = stdin.readLineSync();
          _input = _input ?? "";
          _input = _input.trim();
          try {
            studentsData.remove(_input);
          } catch (e) {
            print("\nStudent not found: $e");
          }
          break;
        case "2":
          stdout.write("\nEnter name, grade (csv): ");
          var _input = stdin.readLineSync();
          _input = _input ?? "";

          var [student, grade] = _input
              .split(",")
              .map((ele) => ele.trim())
              .toList();

          if (studentsData.containsKey(student)) {
            Grade? gradeEnum;

            switch (grade.toLowerCase()) {
              case "a+":
                gradeEnum = Grade.APlus;
                break;
              case "a":
                gradeEnum = Grade.A;
                break;
              case "b+":
                gradeEnum = Grade.BPlus;
                break;
              case "b":
                gradeEnum = Grade.B;
                break;
              case "c+":
                gradeEnum = Grade.CPlus;
                break;
              case "c":
                gradeEnum = Grade.C;
                break;
              case "d+":
                gradeEnum = Grade.DPlus;
                break;
              case "d":
                gradeEnum = Grade.D;
                break;
              case "f":
                gradeEnum = Grade.F;
                break;
            }
            studentsData[student] = gradeEnum ?? Grade.F;
          } else {
            print("\nStudent Not Found, try again!");
          }
          break;
        case "3":
          var total = 0;
          for (var grade in studentsData.values) {
            total += grade.index;
          }

          int avg = total ~/ studentsData.values.length;

          Grade avgGrade = Grade.values[avg];

          print("\nAverage Grade: $avgGrade");
          sleep(Duration(milliseconds: 500));
          break;

        case "4":
          var _min = studentsData.values.reduce((v, e) {
            return v.index > e.index ? e : v;
          });

          print("\nTop Performers: ");
          sleep(Duration(milliseconds: 500));
          Map<String, Grade> topPerformers = {};
          studentsData.forEach((key, value) {
            if (value == _min) topPerformers[key] = value;
          });

          printStudents(topPerformers);
          break;

        case "5":
          stdout.write("\nEnter grade range in csv form: ");
          String? _input = stdin.readLineSync();
          _input = _input ?? "";

          var [gradeOne, gradeTwo] = _input
              .split(",")
              .map((ele) => ele.trim())
              .toList();

          Grade? gradeOneEnum;
          switch (gradeOne.toLowerCase()) {
            case "a+":
              gradeOneEnum = Grade.APlus;
              break;
            case "a":
              gradeOneEnum = Grade.A;
              break;
            case "b+":
              gradeOneEnum = Grade.BPlus;
              break;
            case "b":
              gradeOneEnum = Grade.B;
              break;
            case "c+":
              gradeOneEnum = Grade.CPlus;
              break;
            case "c":
              gradeOneEnum = Grade.C;
              break;
            case "d+":
              gradeOneEnum = Grade.DPlus;
              break;
            case "d":
              gradeOneEnum = Grade.D;
              break;
            case "f":
              gradeOneEnum = Grade.F;
              break;
          }

          Grade? gradeTwoEnum;
          switch (gradeTwo.toLowerCase()) {
            case "a+":
              gradeTwoEnum = Grade.APlus;
              break;
            case "a":
              gradeTwoEnum = Grade.A;
              break;
            case "b+":
              gradeTwoEnum = Grade.BPlus;
              break;
            case "b":
              gradeTwoEnum = Grade.B;
              break;
            case "c+":
              gradeTwoEnum = Grade.CPlus;
              break;
            case "c":
              gradeTwoEnum = Grade.C;
              break;
            case "d+":
              gradeTwoEnum = Grade.DPlus;
              break;
            case "d":
              gradeTwoEnum = Grade.D;
              break;
            case "f":
              gradeTwoEnum = Grade.F;
              break;
          }

          gradeOneEnum = gradeOneEnum ?? Grade.F;
          gradeTwoEnum = gradeTwoEnum ?? Grade.F;
          Map<String, Grade> rangeData = {};
          studentsData.forEach((k, v) {
            if (v.index >= gradeOneEnum!.index &&
                v.index <= gradeTwoEnum!.index)
              rangeData[k] = v;
          });

          printStudents(rangeData);
          sleep(Duration(milliseconds: 500));

          break;
      }
    }
  }

  void display() {
    print("Final Records:\n");
    for (var k in studentsData.keys) {
      print("$k: ${studentsData[k]}");
    }
    print("\n");
    print("Exited Successfully.");
  }
}
