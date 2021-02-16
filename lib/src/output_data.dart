
// header for the @required key word
const fileHeader = ''' 
import 'package:meta/meta.dart';
''';

// a class represneting the query
const queryClassOutput = ''' 
class Query {
  final String query;
  final Map<String, dynamic> variables;

  Query({@required this.query, Map<String, dynamic> variables})
      // to handle default values that passed as null
      : variables = variables..removeWhere((key, value) => value == null);
}
''';

const sortOrderStrings = ''' 

class SortOrder {
/// in the ascending order, nulls last
static const asc = 'asc';

/// in the ascending order, nulls first
static const asc_nulls_first = 'asc_nulls_first';

/// in the ascending order, nulls last
static const asc_nulls_last = 'asc_nulls_last';

/// in the descending order, nulls first
static const desc = 'desc';

/// in the descending order, nulls first
static const desc_nulls_first = 'desc_nulls_first';

/// in the descending order, nulls last
static const desc_nulls_last = 'desc_nulls_last';
}

''';
