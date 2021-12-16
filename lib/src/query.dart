import 'argument.dart';

class Query {
  final String name;
  final List<Argument> arguments;
  final String type;

  // can be a comment or just empty space
  final String precedingBlock;
  final String rawQuery;

  const Query({required this.name, required this.arguments, required this.type, required this.rawQuery, required this.precedingBlock});
}

