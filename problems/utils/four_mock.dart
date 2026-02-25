import 'dart:math';

import 'package:lorem_ipsum/lorem_ipsum.dart';

const numItems = 15;
const priceMultiplier = 10;
const quantityMultiplier = 10;

List<Map<String, dynamic>> getMockCartData() {
  List<Map<String, dynamic>> mockCart = [];

  /*
   * Format:
   *   {
   *    "id": int,
   *    "name": String,
   *    "price": double, (अहिलेको लागि नेपाली रुपैया नै)
   *    "quantity": int,
   *   }
  */

  for (int i = 0; i < numItems; i++) {
    var itemMap = {
      "id": i + 1, // start w/ 1
      "name": loremIpsum(words: 1).trim().replaceAll(".", ""),
      "price": Random().nextDouble() * priceMultiplier,
      "quantity": Random().nextInt(20) * quantityMultiplier,
    };

    mockCart.add(itemMap);
  }

  return mockCart;
}
