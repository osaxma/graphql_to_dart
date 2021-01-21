import 'dart:convert';
import 'dart:io';

Future<void> convert_to_dart(File inputFile, File outputFile) async {
  var outputSink = outputFile.openWrite();

  var stream = inputFile.openRead().transform(utf8.decoder).transform(LineSplitter());

  await stream.forEach((line) => processLines(line, outputSink));

  await outputSink.close();
}

// ================================================= variables 

final queryPostfix = 'Raw';
// ---- mutable variables for processing
var currentOpenBrackets = 0;
var currentType = '';
List<String> fragments = [];

var isCommentBlock = false;
String _line;

var types = ['query', 'mutation', 'subscription', 'fragment'];

bool hasFragment() => fragments.isNotEmpty;



// ================================================= Processor  

void processLines(String line, IOSink outputSink) {
  _line = line;

  // skip empty line
  if (_line.trim().isEmpty) {
    outputSink.writeln(_line);
    return;
  }

  // check if this is a comment block or we are already in a comment block
  if (_line.contains(r'"""') || isCommentBlock) {
    if (!isCommentBlock) {
      isCommentBlock = true;
      _line = _line.replaceFirst(r'"""', '/*');
      // next step will check if this is a single line block so we write later
    }

    if (_line.contains(r'"""')) {
      _line = _line.replaceFirst(r'"""', '*/');
      isCommentBlock = false;
    }

    outputSink.writeln(_line);
    return;
  }

  // change comments from '#' to '//' and move to next line.
  // Don't replace comments inside the query hence check if we are in an open bracket
  if (_line.trim().startsWith('#') && currentOpenBrackets == 0) {
    _line = _line.replaceFirst('#', '//');
    outputSink.writeln(_line);
    return;
  }

  // check if the line has a query if we are not processing one
  if (currentType.isEmpty) {
    currentType = getQueryType(_line);
    // if the currentType still empty, move next line
    if (currentType.isEmpty) {
      outputSink.writeln(_line);
      return;
    }

    if (!_line.contains('{')) {
      throw FormatException('$currentType does not have an open bracket in the same line');
    }
    // if we find a type start the naming
    // outputSink.writeln(); // empty line
    final name = createConstantName(extractNameFromLine(_line), currentType);
    // create the name of the constant
    outputSink.writeln("const $name = '''");
  }

  if (currentType.isNotEmpty) {
    // add an escape character '\' for graphql placeholder '$' => '\$'.
    _line = _line.replaceAll(r'$', r'\$');
    var openingBrackets = RegExp(r'{').allMatches(_line).length;
    var closingBrackets = RegExp(r'}').allMatches(_line).length;
    // count brackets till currentOpenBrackets reaches 0
    currentOpenBrackets = currentOpenBrackets + openingBrackets - closingBrackets;

    // capture fragments
    // if the line has a fragment (they start with three dots)
    if (line.contains('...')) {
      // we add the fragment inside each query at the end
      // tools like hasura needs this for the allow-list
      fragments.add(getFragmentName(line));
    }

    outputSink.writeln(_line);
  }

  if (currentOpenBrackets == 0 && currentType.isNotEmpty) {
    if (hasFragment()) {
      for (var frag in fragments) {
        outputSink.writeln();
        outputSink.writeln(frag);
      }
      fragments.clear();
    }

    outputSink.writeln("''';");
    currentType = '';
  }
}





// ================================================= functions 


// find the first word after the type name:
// e.g. "query getWhatever()"
// regex => (?<=query\s)\w*
// result => "getWhatever"
String extractNameFromLine(String line) {
  // replace any > 2 spaces with 1 space
  final trimmedLine = line.trimLeft().replaceAll(RegExp(r'\s+'), ' ');
  final name = RegExp(r'(?<=' '$currentType' r'\s)\w*').stringMatch(trimmedLine);
  return name;
}

String createConstantName(String name, String type) {
  return '$name$queryPostfix${type[0].toUpperCase() + type.substring(1)}';
}


String getQueryType(String line) {
  for (var type in types) {
    if (line.trim().startsWith(type)) {
      return type;
    }
  }
  return '';
}

String getFragmentName(String line) {
  final leadingSpaces = ' ' * line.indexOf('...');

  // Find the fragment (name, one word) that starts with three dots (e.g., `....profile`)
  final fragment = RegExp(r'(?<=\.{3})(\w+)').firstMatch(line).group(0);
  final fragmentName = createConstantName(fragment, 'fragment');
  return leadingSpaces + '\$' + fragmentName;
}
