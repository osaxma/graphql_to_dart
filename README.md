A simple command-line application for converting a `graphql` to `dart` constants.

Usage:
```sh
dart bin/main.dart -s path/to/input/file.graphql -o path/to/output/file.dart
```

if you've `dartfmt` installed, you can add the format flag to format the dart output file: 
```sh
dart bin/main.dart -s path/to/input/file.graphql -o path/to/output/file.dart -f 
```


### example 
Input graphql file:
```graphql
# a comment

""" 
multi line comment
"""

# guery
query heroComparison($first: Int = 3) {
  leftComparison: hero(episode: EMPIRE) {
    ...comparisonFields
  }
  # comment inside a query
  rightComparison: hero(episode: JEDI) {
    ...comparisonFields
  }
}

# fragment
fragment comparisonFields on Character {
  name
  friendsConnection(first: $first) {
    totalCount
    edges {
      node {
        name
      }
    }
  }
}
```

output dart file:

```dart
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

```

The fragments are added at the bottom of each query in order to work with graphql servers with allow-list security that are strict (e.g. hasura). 