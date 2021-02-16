class Argument {
  String type; // int, String, list, etc.
  String name;
  String defaultValue;

  Argument({
    String type,
    String name,
    String defaultValue,
  }) {
    // TODO: handle timestamptz better, for now the user should take care of this by making
    // the variable name indicative such as "afterTimestamptz"....
    // the problem is that handling the default value is tricky especially for DateTime
    // - it cannot be added as a default argument since it's not const (e.g. DateTime.parse(default value) != const)
    // - the DateTime needs to be converted using toIso8601String().
    // - null cases need to be handled too
    if (type == 'timestamptz') {
      this.type = 'String';
    } else if (type == 'Int') {
      this.type = 'int';
    } else if (type == 'order_by') {
      this.type = 'String';
    } else {
      this.type = type;
    }
    this.name = name;
    this.defaultValue = defaultValue;
  }
}
