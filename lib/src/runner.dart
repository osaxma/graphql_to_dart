import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'converter.dart';
import 'formatter.dart';
import 'util.dart';

Future<void> runner(List<String> arguments) async {
  late Uri sourceUri;
  late Uri outputUri;
  // ------------------------------------------------------------------ Argument Parsing
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', help: 'print the usage', negatable: false)
    ..addOption('source', abbr: 's', help: 'the source graphql file')
    ..addOption('output', abbr: 'o', help: 'the output path')
    ..addFlag('keep', abbr: 'k', help: 'keep the old file (no by default)')
    ..addFlag('format', abbr: 'f', help: 'format the ouput file using `dart format`');

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
        printError('${argResults['source']} does not exist');
      }
    } catch (e) {
      printError('error while parsing the source ${argResults['source']}', e);
      rethrow;
    }
  }

  if (!argResults.wasParsed('output')) {
    stderr.writeln('error: the output graphql file needs to be specificed');
  } else {
    try {
      outputUri = Uri.parse(argResults['output']);
      if (!Directory(p.dirname(outputUri.path)).existsSync()) {
        printError('${p.dirname(outputUri.path)} directory does not exist');
      }
    } catch (e) {
      printError('error while parsing the output path ${argResults['output']}', e);
      rethrow;
    }
  }
  stdout.writeln('starting ...');

  // ------------------------------------------------------------------ Start converting

  final inputFile = File(sourceUri.path);
  final outputFile = File(outputUri.path);

  File? copiedFile;
  try {
    copiedFile = makeCopyIfFileExists(outputFile);
  } catch (e) {
    printError('error while making an old copy of a previously created output file ', e);
  }

  try {
    await convertToDart(inputFile, outputFile);
  } catch (e) {
    printError('error while parsing the input file', e);
    rethrow;
  }

  // ------------------------------------------------------------------ Delete Copied file
  // it's here so we don't delete in case of an error.
  if (!argResults['keep']) {
    copiedFile?.deleteSync();
  }

  // ------------------------------------------------------------------ Format Output
  if (argResults['format']) {
    await formatFile(outputFile);
  }
}

File? makeCopyIfFileExists(File fileToCopy) {
  if (!fileToCopy.existsSync()) return null;

  final filePath = fileToCopy.path;
  final directory = Directory(p.dirname(filePath));

  var newFileName = p.basenameWithoutExtension(filePath) + '_old' + p.extension(filePath);
  // in case the file exists, increment it.
  var i = 0;
  directory.listSync().forEach((element) {
    if (p.basename(element.path) == newFileName) {
      i += 1;
      newFileName = p.basenameWithoutExtension(filePath) + '_old_${i}' + p.extension(filePath);
    }
  });

  return fileToCopy.copySync(p.join(directory.path, newFileName));
}
