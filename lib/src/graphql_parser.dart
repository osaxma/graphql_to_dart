import 'argument.dart';
import 'query.dart';

// The approach here is like a funnel:
// - capture the entire queries (i.e. extractQueries) 
// - In buildQuery, extract the name, and the arguments string
// - In parseQueryArguments, we extract each argument separately
// - for each argument, we extract the name and default value if exists 
//
// this way the lower we go, the more easier and confident we are about what to extract (ie easier regex)

class GraphQLParser {
  GraphQLParser();

  List<Query> extractQueries(String data) {
    final queries = <Query>[];

    final matches = findAllQueriesRegex.allMatches(data);

    var previousMatchEnd = 0;
    for (var i = 0; i < matches.length; i++) {
      final currentMatch = matches.elementAt(i);
      final precedingBlock = data.substring(previousMatchEnd, currentMatch.start);

      final query = buildQuery(currentMatch.group(0), precedingBlock);
      queries.add(query);
      previousMatchEnd = currentMatch.end;
    }

    return queries;
  }

  Query buildQuery(String rawQuery, String precedingBlock) {
    final type = queryTypeRegex.firstMatch(rawQuery).group(0);

    String name;
    if (type == 'fragment') {
      name = fragmentNameRegex.firstMatch(rawQuery).group(0).trim();
    } else {
      name = queryNameRegex.firstMatch(rawQuery).group(0).trim();
    }

    // arguments can be null
    final argumentsRawString = queryArgumentsRegex.firstMatch(rawQuery)?.group(0);
    // fragments don't have arguments
    final arguments = (type != 'fragment') ? parseQueryArguments(argumentsRawString) : null;

    return Query(name: name, type: type, rawQuery: rawQuery, arguments: arguments, precedingBlock: precedingBlock);
  }

  List<Argument> parseQueryArguments(String arguments) {
    var args = <Argument>[];
    if (arguments == null || arguments.trim().isEmpty) return args;
    final argumentsMatches = extractQueryArgumentsFromRawString.allMatches(arguments);

    if (argumentsMatches.isNotEmpty) {
      argumentsMatches.forEach((element) {
        args.add(parseSingleArgument(element.group(0)));
      });
    }
    return args;
  }

  Argument parseSingleArgument(String argument) {
    final argumentName = queryArgumentName.firstMatch(argument).group(0).trim();
    final argumentType = queryArgumentType.firstMatch(argument).group(0).trim();
    // default value can be null
    // 'queryArgumentDefaultValue' captures double quotes and whitespace if there's a default value so they need to be removed
    final defaultValue = queryArgumentDefaultValue.firstMatch(argument)?.group(0)?.trim()?.replaceAll('"', '');
    return Argument(type: argumentType, name: argumentName, defaultValue: defaultValue);
  }
}

/// comments need organizing:
///
///
// find anything between curly brackets  {} even when there are brackets inside...

// (?=\{)(.*|\n)*?(\})

// or even better, capture all queries, mutations, subscriptions and fragments:

// ^(mutation|query|fragment|subscription)(.*|\n)*?(\})

// this assumes graphql file is formated and will find entire queries
final findAllQueriesRegex = RegExp(r'^(mutation|query|fragment|subscription)(.*|\n)*?(\})', multiLine: true);
// this is simply looking what is the type of the query
final queryTypeRegex = RegExp(r'(mutation|query|fragment|subscription)');
// find the name of the query (starts with query type, then maybe any space, then any characters (name) then maybe space (in case query has no arguments so ending would be '{'))
final queryNameRegex = RegExp(r'(?<=(mutation|query|subscription)[\s]+)[\w]+(?=[\s]*(\(|\{))');

final fragmentNameRegex = RegExp(r'(?<=(fragment)[\s]+)[\w]*(?=[\s]+[on])');

// ========== Query Arguments (comments are not organized and came from all over the place)

// rawArgumentString comes in this format:
// ($uid: String!, $photo_url: String!, $foro_id: int!, $somevalue: int) where ! non null
// ($uid: String!, $photo_url: String = "defaultvalue")
//
// regex to match variables: find all that starts with $ and ends with , or closing parentheses:
// \$(.*?)((?=,)|(?=\)))
// or using .+? instead: \$(.+?)((?=,)|(?=\)))
// + means one or more
// * zero or more

//part1:  (?<=(mutation|query|fragment|subscription)[\s]+[\w]*[\s]+)  ==> starts with query type, then any space, then any word, then maybe space
//part2:  [\(].*  ==> starts with a bracket then any characters
// part3: (?<=\)) ==> ends with a bracket
// [\s]+ should capture all whitespace, including spaces, tabs, carriage returns, and some weird whitespace characters.
// Use [\s]* if you want it to be optional.
final queryArgumentsRegex = RegExp(r'(?<=(mutation|query|fragment|subscription)[\s]+[\w]+)\(.*(?<=\))');

// the input argument is in the following format:
//   a string                 a nullable string with default value    a non-null string with default value        a nullable string
// '$uid: String!'    or     '$photo_url: String = "defaultvalue"   or '$photo_url: String! = "defaultvalue" or '$photo_url: String"

// transform this => ($uid: String!, $photo_url: String = "defaultvalue")
// into this => ['$uid: String!', '$photo_url: String = "defaultvalue"', ...]
final extractQueryArgumentsFromRawString = RegExp(r'\$(.+?)((?=,)|(?=\)))');

// get the name that lies between '$' & ':'
// (?<=\$).+?(?=:)
final queryArgumentName = RegExp(r'(?<=\$).+?(?=:)');
// get the type of the argument that comes after ":" that  may end with one of of these , ! ) =
final queryArgumentType = RegExp(r'(?<=:).+?(?=[!|=|,|\)])');

// get the default value after the equal sign where there may be space and it's between double or single quotes.
// (?<==)(\s*)["|'].+["|']
// it can be null
// WARNING this will capture the double-quotes and white spaces, they need to be removed
final queryArgumentDefaultValue = RegExp(r'''(?<==).+''');

// multiline comments in graphql begings with """  and ends with """
final multiLineCommentRegex = RegExp(r'(?="{3})(.*|[\s]*)*?(?<="{3})', multiLine: true);
// comments in graphql starts with #
final singleLineCommentRegex = RegExp(r'^\s*#');

// find fragment name inside a query that starts with '...';
final fragmentNameInsideQueryRegex = RegExp(r'(?<=\.{3})(\w+)');
