class Argument {
  late String type; // int, String, list, etc.
  late String name;
  String? defaultValue;

  Argument({
    required String type,
    required String name,
    String? defaultValue,
    required bool isNullable,
  }) {
    // TODO: handle timestamptz better, for now the user should take care of this by making
    // the variable name indicative such as "afterTimestamptz"....
    // the problem is that handling the default value is tricky especially for DateTime
    // - it cannot be added as a default argument since it's not const (e.g. DateTime.parse(default value) != const)
    // - the DateTime needs to be converted using toIso8601String().

    type = convertGraphQLTypeToDartType(type);

    // since we are adding arguments with default values as named parameters without actually placing
    // the default value (not implemented), we make it nullable. Ideally we should put the default value
    // For now, the default value is only shown in the raw query of the output file.
    if (isNullable || defaultValue != null) {
      this.type = type + '?';
    } else {
      this.type = type;
    }

    this.name = name;
    this.defaultValue = defaultValue;
  }
}

String convertGraphQLTypeToDartType(String type) {
  if (type == 'String' || type == 'String!') {
    return 'String';
  } else if (type == 'timestamptz' || type == 'timestamptz!') {
    return 'String';
  } else if (type == 'Int' || type == 'Int!') {
    return 'int';
  } else if (type == 'order_by' || type == 'order_by!') {
    return 'String';
  } else if (type == 'Boolean' || type == 'Boolean!') {
    return 'bool';
  } else {
    throw Exception('type: $type is Unknown GraphQL type!');
  }
}
