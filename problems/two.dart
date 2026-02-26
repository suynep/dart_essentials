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
  Map<String, Grade> studentsData = {};

  @override
  void getData() {
    bool continueNext = true;

    // this is going to be SO redundant, it makes me cry

    stdout.write("Use Mock Students Data? (y/n) ");
    String mockInputCheck = stdin.readLineSync() ?? "";

    if (mockInputCheck.trim().toLowerCase() == "y") {
      continueNext = false;
      var inputs = generateMockStudentData();

      studentsData = inputs.map((k, v) {
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

        return MapEntry(k, gradeEnum!);
      });
    }

    while (continueNext) {
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

        studentsData[student] =
            gradeEnum ?? Grade.F; // for the time being, revert to F
      } catch (e) {
        print("\nError: $e");
      }
    }
  }

  void printStudents(Map<String, Grade> localStudentsData) {
    const nameFieldLength = 40;
    const gradeFieldLength = 40;

    print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");
    print(
      "|${"name".padRight(nameFieldLength)}|${"grade".padRight(gradeFieldLength)}|",
    );
    print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");

    localStudentsData.forEach((key, value) {
      print(
        "|${key.padRight(nameFieldLength)}|${value.name.padRight(gradeFieldLength)}|",
      );
    });

    print("+${('-' * nameFieldLength)}+${('-' * gradeFieldLength)}+");
  }

  @override
  void wrangleAndCompute() {
    bool continueNext = true;

    stdout.write("""

1: remove student
2: update existing student by name
3: calculate class average
4: find top performer(s)
5: filter by grade range <grade_1, grade_2>
q: quit

""");

    while (continueNext) {
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
          var innerInput = stdin.readLineSync();
          innerInput = innerInput ?? "";
          innerInput = innerInput.trim();
          try {
            studentsData.remove(innerInput);
          } catch (e) {
            print("\nStudent not found: $e");
          }
          break;
        case "2":
          stdout.write("\nEnter name, grade (csv): ");
          var innerInput = stdin.readLineSync();
          innerInput = innerInput ?? "";

          var [student, grade] = innerInput
              .split(",")
              .map((ele) => ele.trim())
              .toList();

          if (studentsData.containsKey(student)) {
            Grade? gradeEnum;

            switch (grade.toLowerCase()) {
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
          var minimum = studentsData.values.reduce((v, e) {
            return v.index > e.index ? e : v;
          });

          print("\nTop Performers: ");
          sleep(Duration(milliseconds: 500));
          Map<String, Grade> topPerformers = {};
          studentsData.forEach((key, value) {
            if (value == minimum) topPerformers[key] = value;
          });

          printStudents(topPerformers);
          break;

        case "5":
          stdout.write("\nEnter grade range in csv form: ");
          String? innerInput = stdin.readLineSync();
          innerInput = innerInput ?? "";

          var [gradeOne, gradeTwo] = innerInput
              .split(",")
              .map((ele) => ele.trim())
              .toList();

          Grade? gradeOneEnum;
          switch (gradeOne.toLowerCase()) {
            case "a+":
              gradeOneEnum = Grade.aPlus;
              break;
            case "a":
              gradeOneEnum = Grade.A;
              break;
            case "b+":
              gradeOneEnum = Grade.bPlus;
              break;
            case "b":
              gradeOneEnum = Grade.B;
              break;
            case "c+":
              gradeOneEnum = Grade.cPlus;
              break;
            case "c":
              gradeOneEnum = Grade.C;
              break;
            case "d+":
              gradeOneEnum = Grade.dPlus;
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
              gradeTwoEnum = Grade.aPlus;
              break;
            case "a":
              gradeTwoEnum = Grade.A;
              break;
            case "b+":
              gradeTwoEnum = Grade.bPlus;
              break;
            case "b":
              gradeTwoEnum = Grade.B;
              break;
            case "c+":
              gradeTwoEnum = Grade.cPlus;
              break;
            case "c":
              gradeTwoEnum = Grade.C;
              break;
            case "d+":
              gradeTwoEnum = Grade.dPlus;
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
                v.index <= gradeTwoEnum!.index) {
              rangeData[k] = v;
            }
          });

          printStudents(rangeData);
          sleep(Duration(milliseconds: 500));

          break;
      }
    }
  }

  @override
  void display() {
    print("Final Records:\n");
    printStudents(studentsData);
    print("\n");
    print("Exited Successfully.");
  }
}
