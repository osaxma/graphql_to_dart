import 'dart:io';
import 'common.dart';
import 'functions_generator.dart';
import 'graphql_parser.dart';
import 'query_object.dart';
import 'util.dart';

Future<void> convert_to_dart(File inputFile, File outputFile) async {
  var outputSink = outputFile.openWrite();

  final data = inputFile.readAsStringSync();

  final queries = GraphQLParser().extractQueries(data); // extractQueries(data);
  final dartConverter = GraphQLToDartConverter();

  outputSink.write(fileHeader);
  outputSink.write(queryClassOutput);

  for (var query in queries) {
    if(query.type == 'fragment') continue;
    outputSink.write(generateQueryFunctionWithArguments(query));
  }

  for (var query in queries) {
    //outputSink.writeln(query.precedingBlock);
    outputSink.write(dartConverter.convert(query));
  }

  await outputSink.close();
}

class GraphQLToDartConverter {

  String convert(Query query) {
    final rawQueryNameForDart = generateRawQueryName(query.name, query.type);
    // add an escape '\' character to all the variables to avoid conflicting with dart 
    final rawQuery = query.rawQuery.replaceAll(r'$', r'\$');
    // create a constant for the raw query and add fragment reference
    final rawQueryForDart = "const $rawQueryNameForDart =  ''' ${addReferenceToFragments(rawQuery)} \n''';";
    // if the preceding docs had comments, change it from graphql to dart (# => // and """ """ => /* */)
    final precedingBlockForDart = '\n' + replaceGraphQLcommentsWithDartComments(query.precedingBlock) + '\n';

    return precedingBlockForDart + rawQueryForDart;
  }


  String addReferenceToFragments(String rawQuery) {
    final matches = fragmentNameInsideQueryRegex.allMatches(rawQuery);
    if (matches.isEmpty) return rawQuery;

    for (var match in matches) {
      final name = r'$' + generateRawQueryName(match.group(0), 'fragment');
      rawQuery = rawQuery.replaceRange(match.start, match.end, name);
    }

    rawQuery = rawQuery.replaceAll('...', '');

    return rawQuery;
  }

  String replaceGraphQLcommentsWithDartComments(String string) {
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
