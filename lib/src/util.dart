import 'dart:io';

void exitWithError(String message, [dynamic error]) {
  stderr.writeln(message);
  if (error != null) stderr.writeln(error);
  exit(2);
}

Future<void> formatFile(File file) async {
  print('running dartfmt...');
  final proc = await Process.run('dartfmt', ['-w', file.path]);
  if (proc.stdout.toString().isNotEmpty) print(proc.stdout);
  if (proc.stderr.toString().isNotEmpty) print(proc.stderr);
  print('Done!');
}
