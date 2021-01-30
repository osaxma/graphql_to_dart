import 'common.dart';
import 'query_object.dart';
// header for the @required key word
const fileHeader = ''' 
import 'package:meta/meta.dart';
''';

// a class represneting the query
const queryClassOutput = ''' 
class Query {
  final String query;
  final Map<String, dynamic> variables;

  const Query({@required this.query, @required this.variables});
}
''';

String generateQueryFunctionWithArguments(Query query) {
  final functionName = query.name;

  var variablesString = '';
  var argumentsString = '';
  for (var arg in query.arguments) {
    argumentsString = argumentsString + arg.type + ' ' + arg.name + ',';
    variablesString = variablesString + "'${arg.name}'" + ':' + arg.name + ',';
  }

  if (argumentsString.isNotEmpty) {
    variablesString = '{' + variablesString + '}';
  } else {
    variablesString = '{}';
  }
  return '''
  
  Query ${functionName}Req($argumentsString) { 
     return Query(query: ${generateRawQueryName(query.name, query.type)}, variables: <String, dynamic>$variablesString,);
  }
  
  ''';

/* example output (after formatting):
Query createPost(
  String post_content,
  String created_by,
  String foro_id,
) {
  return Query(
    query: createPostRawMutation,
    variables: <String, dynamic>{
      'post_content': post_content,
      'created_by': created_by,
      'foro_id': foro_id,
    },
  );
}

*/
}
