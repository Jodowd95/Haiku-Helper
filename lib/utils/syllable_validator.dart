import 'package:english_words/english_words.dart';



String syllableValidator(String value, int syllableThreshold){
  int syllableCount;
  int syllableCountValue = 0;
  if (value != "") {
    List<String> wordList = value.split(" ");
    value.replaceAll(RegExp(r"[^a-zA-Z\d\s:]"), "").trim();
    for (int i = 0; i < wordList.length; i++) {
      syllableCount = int.parse(
          syllables(wordList[i].replaceAll(RegExp(r"[^a-zA-Z\d\s:]"), ""))
              .toString().trim());
      syllableCountValue = syllableCountValue + syllableCount;
    }
  } else {
    value.replaceAll(RegExp(r'[^a-zA-Z\d\s:]'), "");
  }
  if (value.isEmpty) {
    return 'Please enter something';
  } else if (syllableCountValue > syllableThreshold) {
    return "This has to many syllables. Please enter the correct amount";
  } else if (syllableCountValue < syllableThreshold) {
    return "This does not have enough syllables. Please enter the correct amount";
  } else {
    return null;
  }
}
