import 'dart:io';

import '../problems/one.dart';
import '../problems/two.dart';
import '../problems/three.dart';
import '../problems/four.dart';
import '../problems/chooseable_problem.dart';

void main(List<String> arguments) {
  chooseProblem();
}

void chooseProblem() {
  stdout.write("""
1: Solve Problem 1,
2: Solve Problem 2,
3: Solve Problem 3,
4: Solve Problem 4,

""");
  bool _continue = true;

  while (_continue) {
    stdout.write("Enter a choice: ");
    String _input = stdin.readLineSync() ?? "";

    switch (_input.trim()) {
      case "1":
        solveProblem(ProblemOne());
        _continue = false;
        break;
      case "2":
        solveProblem(ProblemTwo());
        _continue = false;
        break;
      case "3":
        solveProblem(ProblemThree());
        _continue = false;
        break;
      case "4":
        solveProblem(ProblemFour());
        _continue = false;
        break;
      default:
        stdout.write("Invalid Option! Try again\n");
    }
  }
}

void solveProblem(IChooseableProblem problem) {
  problem.getData();
  problem.wrangleAndCompute();
  problem.display();
}
