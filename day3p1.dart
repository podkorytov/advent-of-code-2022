import 'dart:io';
import 'dart:convert';

int getScore(String symbol) {
  var ascii = symbol.codeUnitAt(0);
  return ascii < 91 ? ascii - 65 + 27 : ascii - 96;
}

int processLine(String line) {
  var matches = [];
  var len = (line.length / 2).round();

  for (var i = 0; i < len; i++) {
    for (var j = len; j < len * 2; j++) {
      if (line[i] == line[j]) {
        matches.add(line[i]);
        break;
      }
    }
  }
  var sum = 0;
  matches.toSet().forEach((symbol) => sum += getScore(symbol));
  return sum;
}

void main() {
  new File('inputs/input_day3.txt')
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .map((l) => processLine(l))
      .reduce((sum, value) => sum + value)
      .then((s) => print(s));
}
