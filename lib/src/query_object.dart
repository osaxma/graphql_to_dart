import 'util.dart';

class Query {
  final String name;
  final List<Argument> arguments;
  final String type;

  // can be a comment or just empty space
  final String precedingBlock;
  final String rawQuery;

  const Query({this.name, this.arguments, this.type, this.rawQuery, this.precedingBlock});
}

class Argument {
  String type; // int, String, list, etc.
  String name;
  String defaultValue;

  Argument({
    this.type,
    this.name,
    this.defaultValue,
  });
}
