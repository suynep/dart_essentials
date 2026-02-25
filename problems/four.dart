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
  late final List<Map<String, dynamic>> cartData;
  Map<String, dynamic> outputs = {};

  void getData() {
    // !TODO: allow manual inputs
    bool mockData = true;

    if (mockData) {
      cartData = getMockCartData();
    }
  }

  /// call after getData
  void wrangleAndCompute() {
    double calculateTotalPrice() {
      double total = 0;

      cartData.forEach((item) {
        total += item["price"] * item["quantity"];
      });

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

  void display() {
    void displayReceipt() {
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

      print("RECEIPT".padLeft((fieldLength * 1.5).truncate()).padRight((fieldLength * 1.5).truncate()));
      print("+${'-' * fieldLength}+${'-' * fieldLength}+${'-' * fieldLength}+");
      print(
        "|${"item name".padRight(fieldLength)}|${"quantity".padRight(fieldLength)}|${"price".padRight(fieldLength)}|",
      );
      print("+${'-' * fieldLength}+${'-' * fieldLength}+${'-' * fieldLength}+");
      for (var itemMap in cartData) {
        print(
          "|${itemMap['name'].toString().padRight(fieldLength)}|${itemMap['quantity'].toString().padRight(fieldLength)}|${itemMap['price'].toStringAsFixed(2).padRight(fieldLength)}|",
        );
      }
      print("+${'-' * fieldLength}+${'-' * fieldLength}+${'-' * fieldLength}+");
    }

    displayReceipt();
    outputs.forEach((k, v) {
      print("$k: $v");
    });
  }
}
