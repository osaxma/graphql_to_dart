// a comment

/* 
multi line comment
*/

// guery
const heroComparisonRawQuery = '''
query heroComparison(\$first: Int = 3) {
  leftComparison: hero(episode: EMPIRE) {
    ...comparisonFields
  }
  # comment inside a query
  rightComparison: hero(episode: JEDI) {
    ...comparisonFields
  }
}

    $comparisonFieldsRawFragment

    $comparisonFieldsRawFragment
''';

// fragment
const comparisonFieldsRawFragment = '''
fragment comparisonFields on Character {
  name
  friendsConnection(first: \$first) {
    totalCount
    edges {
      node {
        name
      }
    }
  }
}
''';
