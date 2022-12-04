import 'dart:io';
import 'dart:convert';

int getScore(String symbol) {
  var ascii = symbol.codeUnitAt(0);
  return ascii < 91 ? ascii - 65 + 27 : ascii - 96;
}

String findCommon(String line1, String line2) {
  var matches = [];

  for (var i = 0; i < line1.length; i++) {
    for (var j = 0; j < line2.length; j++) {
      if (line1[i] == line2[j]) {
        matches.add(line1[i]);
        break;
      }
    }
  }

  return matches.toSet().toList().join("");
}

int getCommonScore(String line1, String line2, String line3) =>
    getScore(findCommon(findCommon(line1, line2), line3)[0]);

void processLines(List<String> lines) {
  var sum = 0;
  for (var i = 0; i < lines.length; i += 3) {
    sum += getCommonScore(lines[i], lines[i + 1], lines[i + 2]);
  }
  print(sum);
}

void main() {
  new File('inputs/input_day3.txt')
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .toList()
      .then((lines) => processLines(lines));
}
