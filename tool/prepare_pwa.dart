import 'dart:convert';
import 'dart:io';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    stderr.writeln('Usage: dart tool/prepare_pwa.dart <build-web-directory>');
    exitCode = 64;
    return;
  }

  final output = Directory(arguments.single);
  final worker = File('${output.path}/service_worker.js');
  if (!worker.existsSync()) {
    stderr.writeln('Custom service worker not found at ${worker.path}.');
    exitCode = 66;
    return;
  }

  final source = worker.readAsStringSync();
  if (!source.contains('__BUILD_ID__') ||
      !source.contains('__PRECACHE_URLS__')) {
    stderr.writeln('Custom service worker is missing a build placeholder.');
    exitCode = 65;
    return;
  }

  final outputPath = '${output.absolute.path}${Platform.pathSeparator}';
  final files = output
      .listSync(recursive: true)
      .whereType<File>()
      .map((file) => file.absolute.path.substring(outputPath.length))
      .map((path) => path.replaceAll(Platform.pathSeparator, '/'))
      .where(
        (path) =>
            path != 'service_worker.js' && path != 'flutter_service_worker.js',
      )
      .toList()
    ..sort();

  worker.writeAsStringSync(
    source
        .replaceAll(
          '__BUILD_ID__',
          DateTime.now().toUtc().microsecondsSinceEpoch.toString(),
        )
        .replaceAll('__PRECACHE_URLS__', jsonEncode(files)),
  );
}
