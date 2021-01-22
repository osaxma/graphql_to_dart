import 'dart:io';
import 'graphql_parser.dart';
import 'query_object.dart';
import 'util.dart';

Future<void> convert_to_dart(File inputFile, File outputFile) async {
  var outputSink = outputFile.openWrite();

  final data = inputFile.readAsStringSync();

  final queries = GraphQLParser().extractQueries(data); // extractQueries(data);
  final dartConverter = GraphQLToDartConverter();
  for (var query in queries) {
    //outputSink.writeln(query.precedingBlock);
    outputSink.write(dartConverter.convert(query));
  }

  await outputSink.close();
}

class GraphQLToDartConverter {
  final queryPostfix = 'Raw';

  String convert(Query query) {
    final rawQueryNameForDart = generateQueryName(query.name, query.type);
    final rawQuery = query.rawQuery.replaceAll(r'$', r'\$');

    final rawQueryForDart = "const $rawQueryNameForDart =  ''' ${replaceFragments(rawQuery)}''';";
    // just lazily wrapp it with block comment, ain't nobody got time for that
    final precedingBlockForDart = '\n' + replaceComments(query.precedingBlock) + '\n';

    return precedingBlockForDart + rawQueryForDart;
  }

  String generateQueryName(String name, String type) => name + queryPostfix + type.toUpperCaseFirst();

  String replaceFragments(String rawQuery) {
    final matches = fragmentNameInsideQueryRegex.allMatches(rawQuery);
    if (matches.isEmpty) return rawQuery;

    for (var match in matches) {
      final name = r'$' + generateQueryName(match.group(0), 'fragment'.toUpperCaseFirst());
      rawQuery = rawQuery.replaceRange(match.start, match.end, name);
    }

    rawQuery = rawQuery.replaceAll('...', '');

    return rawQuery;
  }

  String replaceComments(String string) {
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
