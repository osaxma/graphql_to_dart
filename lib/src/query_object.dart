

class Query {
  final String name;
  final List<Argument> arguments;
  final String type;

  // can be a comment or just empty space
  final String precedingBlock;
  final String rawQuery;

  const Query({this.name, this.arguments, this.type, this.rawQuery, this.precedingBlock});


}




class Argument {
  String type; // int, String, list, etc.
  String name;
  String defaultValue;

  Argument({
    this.type,
    this.name,
    this.defaultValue,
  });
}


const queryClassOutput = ''' 
class Query {
  final String key;
  final String query;
  final Map<String, dynamic> variables;

  const Query({this.key, @required this.query, @required this.variables});
}
''';

/* eg 

Query getUsersQuery(String uid) {



  Query(query: getUsersRawQuery, );
 } 
*/

String generateQueryFunctionWithArguments(String name, List<Argument> arguments) {
  final functionName = name.replaceAll('Raw', ''); // getUsersRawQuery => getUsersQuery
  var argumentsString = '';
  for (var arg in arguments) {
    argumentsString = argumentsString + arg.type + ' ' + arg.name + ',';
  }
  // remove trailing comment
  if (argumentsString.isNotEmpty) argumentsString = argumentsString.substring(0, argumentsString.length - 1);

  return 'Query $functionName($argumentsString) => Query(query: $name, )';
}

