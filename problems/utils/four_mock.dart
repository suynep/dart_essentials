import 'dart:math';

import 'package:lorem_ipsum/lorem_ipsum.dart';

const numItems = 15;
const priceMultiplier = 10;
const quantityMultiplier = 10;

int globalId = 0;

Map<int, Map<String, dynamic>> getMockCartData() {
  Map<int, Map<String, dynamic>> mockCart = {};

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
      "name": loremIpsum(words: 1).trim().replaceAll(".", ""),
      "price": Random().nextDouble() * priceMultiplier,
      "quantity": Random().nextInt(20) * quantityMultiplier,
    };

    mockCart[globalId] = itemMap;

    globalId += 1;
  }

  return mockCart;
}
