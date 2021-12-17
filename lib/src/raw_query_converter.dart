import 'package:graphql_to_dart/src/query.dart';

import 'common.dart';
import 'regex.dart';

/// Responsible for generating raw query constants
class RawQueryGenerator {
  String generateRawQueriesConstants(Query query) {
    final rawQueryNameForDart = generateRawQueryName(query.name, query.type);
    // add an escape '\' character to all the variables to avoid conflicting with dart
    final rawQuery = query.rawQuery.replaceAll(r'$', r'\$');
    // create a constant for the raw query and add fragment reference
    final rawQueryForDart =
        "const $rawQueryNameForDart =  '''${_addReferenceToFragments(rawQuery)}\n''';";
    // if the preceding docs had comments, change it from graphql to dart (# => // and """ """ => /* */)
    final precedingBlockForDart = '\n' + _replaceGraphQLcommentsWithDartComments(query.precedingBlock) + '\n';

    return precedingBlockForDart + rawQueryForDart;
  }

  String _addReferenceToFragments(String rawQuery) {
    final matches = fragmentNameInsideQueryRegex.allMatches(rawQuery);
    if (matches.isEmpty) return rawQuery;

    for (var match in matches) {
      final name = r'$' + generateRawQueryName(match.group(0)!, 'fragment');
      // add the fragement refrence at the bottom of the query
      rawQuery = rawQuery + '\n' + name;
    }

    return rawQuery;
  }

  String _replaceGraphQLcommentsWithDartComments(String string) {
    var output = <String>[];
    var insideBlockComment = false;
    for (var line in string.split('\n')) {
      if (insideBlockComment) {
        if (line.trim().contains(r'"""')) {
          output.add(line.replaceFirst(r'"""', '*/'));
          insideBlockComment = false;
          continue;
        }
        output.add(line);
        continue;
      }

      if (line.trim().startsWith('#')) {
        output.add(line.replaceFirst('#', '//'));
        continue;
      }
      if (line.trim().startsWith(r'"""')) {
        var out = line.replaceFirst(r'"""', '/*');
        insideBlockComment = true;
        // for same line comment block;
        if (out.contains(r'"""')) {
          out = out.replaceFirst(r'"""', '*/');
          insideBlockComment = false;
        }
        output.add(out);
        continue;
      }

      output.add(line);
    }
    return output.join('\n');
  }
}
