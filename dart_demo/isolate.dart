import 'dart:io';

void main() {
  var file = File('./basic.dart');
  var content = file.readAsStringSync();
  print(content);

  final content2 = file.readAsString();
  content2.then((value) => print(value));
}
