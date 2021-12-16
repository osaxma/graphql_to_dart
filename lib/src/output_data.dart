
// any headers to be added at the top of the generated file.
// TODO: convert any names_with_underscore to lowerCaseCamel
const fileHeader = ''' 
//
// Generated file. Do not edit.
//
''';

// a class represneting the query
const queryClassOutput = r''' 
class Query {
  final String query;
  final Map<String, dynamic> variables;

  Query({required this.query, Map<String, dynamic> variables = const {}})
      // to handle default values that passed as null
      : variables = variables..removeWhere((key, value) => value == null);
  
  @override
  String toString() {
    return 'operation:\n$query\nvariables:\n$variables';
  }
}
''';

const sortOrderStrings = ''' 

class SortOrder {
/// in the ascending order, nulls last
static const asc = 'asc';

/// in the ascending order, nulls first
static const ascNullsFirst = 'asc_nulls_first';

/// in the ascending order, nulls last
static const ascNullsLast = 'asc_nulls_last';

/// in the descending order, nulls first
static const desc = 'desc';

/// in the descending order, nulls first
static const descNullsFirst = 'desc_nulls_first';

/// in the descending order, nulls last
static const descNullsLast = 'desc_nulls_last';
}

''';
