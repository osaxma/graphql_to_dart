import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'converter.dart';
import 'formatter.dart';
import 'util.dart';

void runner(List<String> arguments) async {
  Uri sourceUri;
  Uri outputUri;
  // ------------------------------------------------------------------ Argument Parsing
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', help: 'print the usage', negatable: false)
    ..addFlag('format', abbr: 'f', help: 'format the ouput file using dartfmt (dartfmt must be installed)')
    ..addOption('source', abbr: 's', help: 'the source graphql file')
    ..addOption('output', abbr: 'o', help: 'the output path')
    ..addSeparator('==============');

  final argResults = parser.parse(arguments);

  if (argResults.wasParsed('help')) {
    print(''' 
a utlity script that converts graphql queries into dart constants. 
usage 

Usage: graphql_to_dart [arguments]
    ''');
    print(parser.usage);
    exit(0);
  }

  if (!argResults.wasParsed('source')) {
    stderr.writeln('error: the source graphql file needs to be specificed');
  } else {
    //print(argResults['source']);
    try {
      sourceUri = Uri.parse(argResults['source']);

      if (!File(sourceUri.path).existsSync()) {
        exitWithError('${argResults['source']} does not exist');
      }
    } catch (e) {
      exitWithError('error while parsing the source ${argResults['source']}', e);
    }
  }

  if (!argResults.wasParsed('output')) {
    stderr.writeln('error: the output graphql file needs to be specificed');
  } else {
    try {
      outputUri = Uri.parse(argResults['output']);
      if (!Directory(p.dirname(outputUri.path)).existsSync()) {
        exitWithError('${p.dirname(outputUri.path)} directory does not exist');
      }
    } catch (e) {
      exitWithError('error while parsing the output path ${argResults['output']}', e);
    }
  }
  stdout.writeln('starting ...');
  //  stdin.readLineSync();

  print('reading from ${sourceUri.path}');
  print('writing to ${outputUri.path}');

  // ------------------------------------------------------------------ Start converting

  final inputFile = File(sourceUri.path);
  final outputFile = File(outputUri.path);

  try {
    await convert_to_dart(inputFile, outputFile);
  } catch (e) {
    stderr.writeln(e.toString());
    exit(2);
  }
  // ------------------------------------------------------------------ Format Output

  if (argResults['format']) {
    await formatFile(outputFile);
  }

}
