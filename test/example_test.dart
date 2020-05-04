import 'package:test/test.dart';
import 'package:argparser/argparser.dart' as ap;

void main() {
  test('NPM install', () {
    var output = ap.parse(
      ['npm', 'install', 'react', '--save'],
      ap.Options(boolean: ['save', 'save-dev']),
    );
    expect(output.primary, equals(['npm', 'install', 'react']));
    expect(output.options, equals({'save': true}));
  });

  test('Linux apt install', () {
    var output = ap.parse(['sudo', 'apt', 'install', 'dart']);
    expect(output.primary, equals(['sudo', 'apt', 'install', 'dart']));
    expect(output.options, equals({}));
  });

  test('NPM list global modules', () {
    var output = ap.parse(['npm', 'list', '--depth=0']);
    expect(output.primary, equals(['npm', 'list']));
    expect(output.options, equals({'depth': '0'}));
  });

  test('Unix remove a directory', () {
    var output = ap.parse(['rm', '-rf', 'directory']);
    expect(output.primary, equals(['rm', 'directory']));
    expect(output.options, equals({'r': true, 'f': true}));
  });
}
