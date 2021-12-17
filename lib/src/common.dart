import 'util.dart';

final queryPostfix = 'Raw';

// raw query are made private to the file so they don't pollute autocompletion
String generateRawQueryName(String name, String type) => '_' + name.toLowerCaseFirst() + queryPostfix + type.toUpperCaseFirst();
