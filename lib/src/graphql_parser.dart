import 'argument.dart';
import 'query.dart';
import 'regex.dart';

// The approach here is like a funnel:
// - capture the entire queries (i.e. extractQueries)
// - In buildQuery, extract the name, and the arguments string
// - In parseQueryArguments, we extract each argument separately
// - for each argument, we extract the name and default value if exists
//
// this way the lower we go, the more easier and confident we are about what to extract (ie easier regex)
//
// note:
// - currently we are not doing anything with the default value except that we check if one exists
//
// - need to handle a way to figure out if the default value is nullable and put it as an optional argument in the output

class GraphQLParser {
  GraphQLParser();

  List<Query> extractQueries(String data) {
    final queries = <Query>[];

    final matches = findAllQueriesRegex.allMatches(data);

    var previousMatchEnd = 0;
    for (var i = 0; i < matches.length; i++) {
      final currentMatch = matches.elementAt(i);
      final precedingBlock = data.substring(previousMatchEnd, currentMatch.start);

      final query = _buildQuery(currentMatch.group(0)!, precedingBlock);
      queries.add(query);
      previousMatchEnd = currentMatch.end;
    }

    return queries;
  }

  Query _buildQuery(String rawQuery, String precedingBlock) {
    final type = queryTypeRegex.firstMatch(rawQuery)!.group(0)!;

    String name;
    if (type == 'fragment') {
      name = fragmentNameRegex.firstMatch(rawQuery)!.group(0)!.trim();
    } else {
      name = queryNameRegex.firstMatch(rawQuery)!.group(0)!.trim();
    }

    // arguments can be null
    final argumentsRawString = queryArgumentsRegex.firstMatch(rawQuery)?.group(0);
    // fragments don't have arguments
    final arguments = (type != 'fragment') ? _parseQueryArguments(argumentsRawString) : const <Argument>[];

    return Query(name: name, type: type, rawQuery: rawQuery, arguments: arguments, precedingBlock: precedingBlock);
  }

  List<Argument> _parseQueryArguments(String? arguments) {
    var args = <Argument>[];
    if (arguments == null || arguments.trim().isEmpty) return args;
    final argumentsMatches = extractQueryArgumentsFromRawString.allMatches(arguments);

    if (argumentsMatches.isNotEmpty) {
      argumentsMatches.forEach((element) {
        args.add(_parseSingleArgument(element.group(0)!));
      });
    }
    return args;
  }

  Argument _parseSingleArgument(String argument) {
    final isNullable = !argument.contains('!');
    final argumentName = queryArgumentName.firstMatch(argument)!.group(0)!.trim();
    final argumentType = queryArgumentType.firstMatch(argument)!.group(0)!.trim();
    // default value can be null
    // 'queryArgumentDefaultValue' captures double quotes and whitespace if there's a default value so they need to be removed
    final defaultValue = queryArgumentDefaultValue.firstMatch(argument)?.group(0)?.trim().replaceAll('"', '');
    return Argument(
      type: argumentType,
      name: argumentName,
      defaultValue: defaultValue,
      isNullable: isNullable,
    );
  }
}
