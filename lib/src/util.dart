import 'dart:io';

void exitWithError(String message, [dynamic error]) {
  stderr.writeln(message);
  if (error != null) stderr.writeln(error);
  exit(2);
}
