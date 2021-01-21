import 'dart:io';

Future<void> formatFile(File file) async {
  print('running dartfmt...');
  final proc = await Process.run('dartfmt', ['-w', file.path]);
  if (proc.stdout.toString().isNotEmpty) print(proc.stdout);
  if (proc.stderr.toString().isNotEmpty) print(proc.stderr);
  print('Done!');
}
