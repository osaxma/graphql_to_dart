class Argument {
  late String type; // int, String, list, etc.
  late String name;
  String? defaultValue;

  Argument({
    required String type,
    required String name,
    String? defaultValue,
  }) {
    // TODO: handle timestamptz better, for now the user should take care of this by making
    // the variable name indicative such as "afterTimestamptz"....
    // the problem is that handling the default value is tricky especially for DateTime
    // - it cannot be added as a default argument since it's not const (e.g. DateTime.parse(default value) != const)
    // - the DateTime needs to be converted using toIso8601String().

    this.type = convertGraphQLTypeToDartType(type);
    this.name = name.trim();
    this.defaultValue = defaultValue?.trim().replaceAll('\"', "\'");
    ;
  }

  String get defaultValueAsDart {
    if (defaultValue == null || type.contains('?')) return '';

    if (type.startsWith('String')) {
      if (!defaultValue!.contains('\"') && !defaultValue!.contains("\'")) {
        return "='$defaultValue'";
      }
    }

    return '=$defaultValue';
  }
}

final typeFromlist = RegExp(r'(?<=\[).*(?=\])');
String convertGraphQLTypeToDartType(String type) {
  type = type.trim();
  // check if it's a list
  if (type.contains('[') && type.contains(']')) {
    final genericType = typeFromlist.firstMatch(type)!.group(0)!;
    final isNullable = !type.endsWith('!');

    if (isNullable) {
      return 'List<' + convertGraphQLTypeToDartType(genericType) + '>?';
    } else {
      return 'List<' + convertGraphQLTypeToDartType(genericType) + '>';
    }
  }

  if (type == 'String' || type == 'order_by' || type == 'timestamptz' || type == 'json') {
    return 'String?';
  } else if (type == 'String!' || type == 'order_by!' || type == 'timestamptz!' || type == 'json!') {
    return 'String';
  } else if (type == 'Int') {
    return 'int?';
  } else if (type == 'Int!') {
    return 'int';
  } else if (type == 'Boolean') {
    return 'bool?';
  } else if (type == 'Boolean!') {
    return 'bool';
  } else {
    throw Exception('type: $type is Unknown GraphQL type!');
  }
}
