import "package:lorem_ipsum/lorem_ipsum.dart";
import "dart:math";

const validGrades = ["A+", "A", "B+", "B", "C+", "C", "D+", "D", "F"];
const numData = 15;

void showBanner() {
  print(r"""
                                    __                      __                        __     
                                   /  |                    /  |                      /  |    
  ______    ______   ______    ____$$ |  ______        ____$$ |  ______    ______   _$$ |_   
 /      \  /      \ /      \  /    $$ | /      \      /    $$ | /      \  /      \ / $$   |  
/$$$$$$  |/$$$$$$  |$$$$$$  |/$$$$$$$ |/$$$$$$  |    /$$$$$$$ | $$$$$$  |/$$$$$$  |$$$$$$/   
$$ |  $$ |$$ |  $$/ /    $$ |$$ |  $$ |$$    $$ |    $$ |  $$ | /    $$ |$$ |  $$/   $$ | __ 
$$ \__$$ |$$ |     /$$$$$$$ |$$ \__$$ |$$$$$$$$/  __ $$ \__$$ |/$$$$$$$ |$$ |        $$ |/  |
$$    $$ |$$ |     $$    $$ |$$    $$ |$$       |/  |$$    $$ |$$    $$ |$$ |        $$  $$/ 
 $$$$$$$ |$$/       $$$$$$$/  $$$$$$$/  $$$$$$$/ $$/  $$$$$$$/  $$$$$$$/ $$/          $$$$/  
/  \__$$ |                                                                                   
$$    $$/                                                                                    
 $$$$$$/                                                                                     

""");
}

Map<String, String> generateMockStudentData() {
  Map<String, String> studentsData = {};

  for (int i = 0; i < numData; i++) {
    studentsData[loremIpsum(words: 1).replaceAll(RegExp(r"[\.]+"), "")] =
        validGrades[Random().nextInt(validGrades.length)];
  }

  return studentsData;
}
