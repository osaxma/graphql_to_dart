import 'dart:io';

void formatFile(File file) {
  final proc = Process.runSync('dart', ['format', file.path]);
  if (proc.stdout.toString().trim().isNotEmpty) print(proc.stdout);
  if (proc.stderr.toString().trim().isNotEmpty) print(proc.stderr);
}
