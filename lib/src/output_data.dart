
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

  Query({required String query, Map<String, dynamic> variables = const {}})
      // to handle default values that passed as null
      : variables = variables..removeWhere((key, value) => value == null),
        query = _removeDuplicateFragments(query);

  @override
  String toString() {
    return 'operation:\n$query\nvariables:\n$variables';
  }
}

// a temporary work around to remove duplicate fragemtns to avoid the following error:
//  `multiple definitions for fragment "FragmentName"`
// this may fail if the closing curly bracket of the fragment has whitespace before it.
final _captureAllFragements = RegExp(r'fragment.*\{(.|\n)+?^\}', multiLine: true);
String _removeDuplicateFragments(String string) {
  if (!string.contains('fragment')) return string;
  final matches = _captureAllFragements.allMatches(string).toList();
  if (matches.isEmpty) return string;
  final uniqueFragments = matches.map((m) => m.group(0)).toSet().reduce(
        (pre, ele) => (pre ?? '') + '\n\n' + (ele ?? ''),
      );
  string = string.replaceAll(_captureAllFragements, '').trim() + '\n\n' + uniqueFragments!;
  return string;
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
