import 'package:argparser/argparser.dart' as ap;

void main(List<String> args) {
  var arguments = ap.parse(
    args,
    ap.Options(boolean: [], alias: [], defaults: {}),
  );

  print('primary: ');
  print(arguments.primary);
  print('options: ');
  print(arguments.options);
}
