import 'util.dart';

final queryPostfix = 'Raw';

String generateRawQueryName(String name, String type) => name + queryPostfix + type.toUpperCaseFirst();
