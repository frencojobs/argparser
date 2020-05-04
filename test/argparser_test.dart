import 'package:test/test.dart';
import 'package:argparser/argparser.dart' as ap;

void main() {
  group('Without options ->', () {
    test('Returns empty output if args in empty', () {
      var output = ap.parse([]);
      expect(output.primary, equals([]));
      expect(output.options, equals({}));
    });

    test('Single primary argument', () {
      var output = ap.parse(['foo']);
      expect(output.primary, equals(['foo']));
      expect(output.options, equals({}));
    });

    test('Single option argument', () {
      var output = ap.parse(['--bar']);
      expect(output.primary, equals([]));
      expect(output.options, equals({'bar': true}));
    });

    test('Single tiny option argument', () {
      var output = ap.parse(['-c']);
      expect(output.primary, equals([]));
      expect(output.options, equals({'c': true}));
    });

    test('Option argument with value', () {
      var output = ap.parse(['--bar', 'baz']);
      expect(output.primary, equals([]));
      expect(output.options, equals({'bar': 'baz'}));
    });

    test('Positional primary arguments', () {
      var output = ap.parse(['--', 'foo', 'bar']);
      expect(output.primary, equals(['foo', 'bar']));
      expect(output.options, equals({}));
    });

    test('Primary argument with options without value', () {
      var output = ap.parse(['foo', '--bar', '--baz', '--fiz']);
      expect(output.primary, equals(['foo']));
      expect(output.options, equals({'bar': true, 'baz': true, 'fiz': true}));
    });

    test('Primary argument with options with value', () {
      var output = ap.parse(['foo', '--bar', 'baz', '--fiz', 'buz']);
      expect(output.primary, equals(['foo']));
      expect(output.options, equals({'bar': 'baz', 'fiz': 'buz'}));
    });

    test('Primary argument with one tiny option', () {
      var output = ap.parse(['foo', '-b']);
      expect(output.primary, equals(['foo']));
      expect(output.options, equals({'b': true}));
    });

    test('Primary argument with multiple tiny options', () {
      var output = ap.parse(['foo', '-bar']);
      expect(output.primary, equals(['foo']));
      expect(output.options, equals({'b': true, 'a': true, 'r': true}));
    });

    test('Everything combined', () {
      var output = ap.parse([
        'foo',
        '--bar',
        'baz',
        '--fiz',
        '-wxy',
        '--',
        'biz',
      ]);
      expect(output.primary, equals(['foo', 'biz']));
      expect(
          output.options,
          equals({
            'bar': 'baz',
            'fiz': true,
            'w': true,
            'x': true,
            'y': true,
          }));
    });
  });

  group('With options ->', () {
    test('Options for boolean', () {
      var output = ap.parse(
        ['--bar', 'baz'],
        ap.Options(boolean: ['bar']),
      );
      expect(output.primary, equals(['baz']));
      expect(output.options, equals({'bar': true}));
    });

    test('Boolean option with assigned value', () {
      var output = ap.parse(
        ['--bar=baz'],
        ap.Options(boolean: ['bar']),
      );
      expect(output.primary, equals([]));
      expect(output.options, equals({'bar': true}));
    });

    test('Options for alias', () {
      var output = ap.parse(
        ['--bar', 'baz'],
        ap.Options(alias: [
          ['bar', 'b']
        ]),
      );
      expect(output.primary, equals([]));
      expect(output.options, equals({'bar': 'baz', 'b': 'baz'}));
    });

    test('Options for defaults', () {
      var output = ap.parse(
        ['--foo'],
        ap.Options(defaults: {'bar': 'baz'}),
      );
      expect(output.primary, equals([]));
      expect(output.options, equals({'foo': true, 'bar': 'baz'}));
    });

    test('Every options combined', () {
      var output = ap.parse(
        ['foo', '--bar', 'baz'],
        ap.Options(
          boolean: ['bar'],
          defaults: {'fiz': 'buzz'},
          alias: [
            ['bar', 'b']
          ],
        ),
      );
      expect(output.primary, equals(['foo', 'baz']));
      expect(output.options, equals({'bar': true, 'b': true, 'fiz': 'buzz'}));
    });
  });
}
