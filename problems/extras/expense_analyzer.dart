import 'dart:io';
import 'dart:typed_data';

typedef ExpenseRecord = (String category, double? price);

class ExpenseAnalyzer {
  List<ExpenseRecord> data = [];

  List<String> expensiveLoad() {
    String path = "../mock/expense_analyzer_data.csv";

    List<String> f = File(path).readAsLinesSync().skip(1).toList();

    return f;
  }

  void populate() {
    var data_ = expensiveLoad();

    data_.forEach((e) {
      var splitString = e.split(",");

      data.add((splitString[0], double.tryParse(splitString[1])));
    });
  }
}

main() {
  var eA = ExpenseAnalyzer()..populate();
  print(eA.data);
}
