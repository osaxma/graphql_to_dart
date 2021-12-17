import 'dart:io';

void printErrorAndExit(String message, [dynamic error]) {
  stderr.writeln(message);
  if (error != null) stderr.writeln(error);
  exitCode = 1;
  exit(0);
}

extension FirstLetterCase on String {
  String toUpperCaseFirst() => '${this[0].toUpperCase()}${substring(1)}';
  String toLowerCaseFirst() => '${this[0].toLowerCase()}${substring(1)}';

  /// this will remove extra spaces (i.e., > 1 space in sequence);
  String removeExtraSpace() => replaceAll(RegExp(r'\s{2,}'), ' ');

  String toLowerCaseCamel() {
    if (!contains('_')) return this;

    return split('_').reduce((value, element) => value + element.toUpperCaseFirst());
  }

  /// trims leading whitespace
  String ltrim() {
    return replaceFirst(RegExp(r'^\s+'), '');
  }

  /// trims trailing whitespace
  String rtrim() {
    return replaceFirst(RegExp(r'\s+$'), '');
  }

  // not tested
  /// this will remove extra spaces (i.e., > 1 space in sequence);
  // String removeExtraWhiteSpaces() => replaceAll(RegExp(r'\s+', multiLine: true), ' ');
}
