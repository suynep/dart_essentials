import 'package:week_2_problems/week_2_problems.dart' as week_2_problems;
import '../problems/one.dart';
import '../problems/two.dart';
import '../problems/three.dart';
import '../problems/chooseable_problem.dart';

void main(List<String> arguments) {
  solveProblem(ProblemThree());
}

void solveProblem(IChooseableProblem problem) {
  problem.getData();
  problem.wrangleAndCompute();
  problem.display();
}
