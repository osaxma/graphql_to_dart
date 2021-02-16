import 'common.dart';
import 'query.dart';

String generateQueryFunctionWithArguments(Query query) {
  final functionName = query.name;
  final argumentsWithDefaultValue = [];
  var variablesString = '';
  var argumentsString = '';
  for (var arg in query.arguments) {
    if (arg.defaultValue != null) {
      argumentsWithDefaultValue.add(arg);
      continue;
    }
    argumentsString = argumentsString + arg.type + ' ' + arg.name + ',';
    variablesString = variablesString + "'${arg.name}'" + ':' + arg.name + ',';
  }
  // handle default values and add them as optional named arguments
  if (argumentsWithDefaultValue.isNotEmpty) {
    argumentsString = argumentsString + '{';
    for (var arg in argumentsWithDefaultValue) {
      argumentsString = argumentsString + arg.type + ' ' + arg.name + ',';
      variablesString = variablesString + "'${arg.name}'" + ':' + arg.name + ',';
    }
    argumentsString = argumentsString + '}';
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
