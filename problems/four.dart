// ### Project 4: Shopping Cart
// Create a program that:
// - Manages items with name, price, quantity
// - Uses Lists and Maps
// - Calculates total price
// - Applies discounts
// - Generates receipt

import 'dart:io';

import 'chooseable_problem.dart';
import 'utils/four_mock.dart';

class ProblemFour implements IChooseableProblem {
  late final Map<int, Map<String, dynamic>> cartData;
  Map<String, dynamic> outputs = {};
  late double discount; // default

  @override
  void getData() {
    showBanner(); // avoid this on small terminal sizes...hmm..

    // !TODO: allow manual inputs
    bool mockData = true;

    // set discount, as this is the first method that'll be called
    bool valid = true;
    do {
      valid = true;
      stdout.write("Enter Discount Amount: ");
      String discountInput = stdin.readLineSync() ?? "";

      try {
        double discountInputAsDouble = double.parse(discountInput);
        discount = discountInputAsDouble;
      } on FormatException {
        print("Enter a valid discount!");
        valid = false;
      }
    } while (!valid);

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
      discount,
    ).toStringAsFixed(2);

    displayChoices();

    int choice = 0;

    do {
      choice = getChoiceInput();
      switch (choice) {
        case 1:
          var data = addDataInput();
          cartData[globalId] = data;
          globalId++;
          sleep(Duration(seconds: 1));
          print("Added Successfully");
          break;
        case 2:
          var data = updateDataInput();
          Map<String, dynamic> modifiedData = {};

          data.forEach((key, value) {
            if (key != "id") {
              modifiedData[key] = value;
            }
          });

          cartData[data["id"] as int] = modifiedData;

          sleep(Duration(seconds: 1));
          print("Updated Successfully");

          break;
        case 3:
          deleteDataInput();
          break;
        case 4:
          displayReceipt(cartData);
          break;
      }
    } while (choice != 5);
  }

  void deleteDataInput() {
    bool valid = true;
    do {
      valid = true;

      stdout.write("Enter id: ");
      String idInput = stdin.readLineSync() ?? "";

      if (idInput.isEmpty) {
        stdout.write("Id cannot be empty");
        valid = false;
      } else {
        try {
          int idInputAsInt = int.parse(idInput.trim());
          if (cartData.keys.contains(idInputAsInt)) {
            cartData.remove(idInputAsInt);
            print("Data Removed Successfully");
          } else {
            print("Data ID not valid!");
            valid = false;
          }
        } on FormatException {
          valid = false;
          print("Non numeric Id Detected");
        }
      }
    } while (!valid);
  }

  void displayChoices() {
    stdout.write("""
1: add data
2: update existing data by id
3: delete data by id
4: view all data
5: Display Result & Exit
""");
  }

  int getChoiceInput() {
    bool valid = true;
    do {
      valid = true;
      stdout.write("Enter choice: ");
      String choiceInput = stdin.readLineSync() ?? "";

      try {
        int choiceInputAsInt = int.parse(choiceInput.trim());
        return choiceInputAsInt;
      } on FormatException {
        print("Cannot parse Choice");
        valid = false;
      }
    } while (!valid);
  }

  Map<String, Object> addDataInput() {
    bool valid = true;

    Map<String, Object> receivedData = {};

    do {
      valid = true;
      stdout.write("Enter name: ");
      String nameInput = stdin.readLineSync() ?? "";

      if (nameInput.isEmpty) {
        stdout.write("Name cannot be empty");
        valid = false;
      } else {
        receivedData["name"] = nameInput.trim();
      }

      stdout.write("Enter price: ");
      String priceInput = stdin.readLineSync() ?? "";

      if (priceInput.isEmpty) {
        stdout.write("Price cannot be empty");
        valid = false;
      } else {
        try {
          double priceInputAsDouble = double.parse(priceInput.trim());
          receivedData["price"] = priceInputAsDouble;
        } on FormatException {
          print("Not a valid number");
          print("Try again");
          valid = false;
        }
      }

      stdout.write("Enter quantity: ");
      String quantityInput = stdin.readLineSync() ?? "";

      if (quantityInput.isEmpty) {
        stdout.write("Quantity cannot be empty");
        valid = false;
      } else {
        try {
          int quantityInputAsInt = int.parse(quantityInput.trim());
          receivedData["quantity"] = quantityInputAsInt;
        } on FormatException {
          print("Not a valid number");
          print("Try again");
          valid = false;
        }
      }
    } while (!valid);

    return receivedData;
  }

  Map<String, Object> updateDataInput() {
    bool valid = true;

    Map<String, Object> receivedData = {};

    do {
      valid = true;

      stdout.write("Enter id: ");
      String idInput = stdin.readLineSync() ?? "";

      if (idInput.isEmpty) {
        stdout.write("Id cannot be empty");
        valid = false;
      } else {
        try {
          int idInputAsInt = int.parse(idInput.trim());
          receivedData["id"] = idInputAsInt;
        } on FormatException {
          valid = false;
          print("Non numeric Id Detected");
        }
      }

      stdout.write("Enter name: ");
      String nameInput = stdin.readLineSync() ?? "";

      if (nameInput.isEmpty) {
        stdout.write("Name cannot be empty");
        valid = false;
      } else {
        receivedData["name"] = nameInput.trim();
      }

      stdout.write("Enter price: ");
      String priceInput = stdin.readLineSync() ?? "";

      if (priceInput.isEmpty) {
        stdout.write("Price cannot be empty");
        valid = false;
      } else {
        try {
          double priceInputAsDouble = double.parse(priceInput.trim());
          receivedData["price"] = priceInputAsDouble;
        } on FormatException {
          print("Not a valid number");
          print("Try again");
          valid = false;
        }
      }

      stdout.write("Enter quantity: ");
      String quantityInput = stdin.readLineSync() ?? "";

      if (quantityInput.isEmpty) {
        stdout.write("Quantity cannot be empty");
        valid = false;
      } else {
        try {
          int quantityInputAsInt = int.parse(quantityInput.trim());
          receivedData["quantity"] = quantityInputAsInt;
        } on FormatException {
          print("Not a valid number");
          print("Try again");
          valid = false;
        }
      }
    } while (!valid);

    return receivedData;
  }

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

  @override
  void display() {
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
            // rowString += "${i.toString().padRight(columnSize)}|";
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
