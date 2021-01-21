import 'dart:io';

import 'package:graphql_to_dart/graphql_to_dart.dart';

void main(List<String> arguments) async {
  try {
    await runner(arguments);
  } catch (e) {
    stderr.writeln(e);
    exit(2);
  }
  exit(0);
}
