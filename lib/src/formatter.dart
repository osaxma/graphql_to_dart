import 'dart:io';

Future<void> formatFile(File file) async {
  final proc = await Process.runSync('dart', ['format', file.path]);
  if (proc.stdout.toString().trim().isNotEmpty) print(proc.stdout);
  if (proc.stderr.toString().trim().isNotEmpty) print(proc.stderr);
  print('Done!');
}
