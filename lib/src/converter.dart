import 'dart:io';

import 'output_data.dart';
import 'raw_query_converter.dart';
import 'functions_generator.dart';
import 'graphql_parser.dart';

Future<void> convertToDart(File inputFile, File outputFile) async {
  final outputSink = outputFile.openWrite();

  final data = inputFile.readAsStringSync();

  final queries = GraphQLParser().extractQueries(data);
  final dartConverter = RawQueryGenerator();

  outputSink.write(fileHeader);
  outputSink.write(queryClassOutput);
  outputSink.write(sortOrderStrings);

  // first generate the functions that will be used by the user
  for (var query in queries) {
    // fragments don't have functions 
    if (query.type != 'fragment') {
      outputSink.write(generateQueryFunctionWithArguments(query));
    }

    outputSink.write(dartConverter.generateRawQueriesConstants(query));
    outputSink.writeln();
  }

  await outputSink.close();
}
