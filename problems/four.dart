// ### Project 4: Shopping Cart
// Create a program that:
// - Manages items with name, price, quantity
// - Uses Lists and Maps
// - Calculates total price
// - Applies discounts
// - Generates receipt

import 'chooseable_problem.dart';
import 'utils/four_mock.dart';

class ProblemFour implements IChooseableProblem {
  late final Map<int, Map<String, dynamic>> cartData;
  Map<String, dynamic> outputs = {};

  @override
  void getData() {
    // !TODO: allow manual inputs
    bool mockData = true;

    if (mockData) {
      cartData = getMockCartData();
    }
  }

  /// call after getData
  @override
  void wrangleAndCompute() {
    double calculateTotalPrice() {
      double total = 0;

      for (var key in cartData.keys) {
        total += cartData[key]!["price"] * cartData[key]!["quantity"];
      }

      return total;
    }

    double calculateDiscountedPrice(double totalPrice, double discountPercent) {
      if (discountPercent > 100) {
        return 0;
      }
      outputs["discount"] = discountPercent;

      return (totalPrice - totalPrice * (discountPercent / 100));
    }

    outputs["total"] = calculateTotalPrice().toStringAsFixed(2);
    outputs["totalAfterDiscount"] = calculateDiscountedPrice(
      calculateTotalPrice(),
      15,
    ).toStringAsFixed(2);
  }

  @override
  void display() {
    void displayReceipt(Map<int, Map<String, dynamic>> localCartData) {
      /*
      * +-----------+---------------+------------+
      * | item_name | item_quantity | item_price |
      * |-----------|---------------|------------|
      * | something | 12            | 3.99       |
      * +-----------+---------------+------------+
      * Raw Total: <total>
      * Applied Discount: <discount%>
      * Total after discount: <discounted total>
      */

      const fieldLength = 25; // 30 chars per field

      print(
        "RECEIPT"
            .padLeft((fieldLength * 1.5).truncate())
            .padRight((fieldLength * 1.5).truncate()),
      );

      PrettyPrint().printTable(
        cartData,
        titles: ["id", "Item Name", "Item Price", "Item Quantity"],
      );
    }

    displayReceipt(cartData);
    outputs.forEach((k, v) {
      print("$k: $v");
    });
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
      for (int i = 0; i < records.length; i++) {
        if (records is List) {
          String rowString = "|";
          for (var ele in records[i]) {
            rowString += "${ele.toString().padRight(columnSize)}|";
          }
          print(rowString);
        } else if (records is Map) {
          // presently, this is tailored for THIS use case ONLY, not a generic handler
          String rowString = "|${i.toString().padRight(columnSize)}|";
          for (var key in records[i].keys) {
            // rowString += "${i.toString().padRight(columnSize)}|";
              rowString += "${records[i][key].toString().padRight(columnSize)}|";
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
