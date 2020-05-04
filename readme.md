# Argparser

Argparser helps you parse command-line arguments and flags easily.

## Usage

Follow the instructions from pub.dev to depend on the argparser package. Then argparser should be able to use as in the following examples.

```dart
// main.dart
import 'package:argparser/argparser.dart' as ap;

void main(List<String> args) {
  var arguments = ap.parse(args);

  print(arguments.primary);
  print(arguments.options);
}
```

```bash
dart main.dart need -a --much=better -- example

// [need, example]
// {a: true, much: better}
```

## API

### `parse(List<String> args, Options options)`

#### `args`

List of arguments strings, can be used directly from the main function argument.

#### `List<String> options.boolean`

List of keys for options that will be parsed as boolean values.

```dart
var output = ap.parse(['--for', 'sure'])
// output.primary -> []
// output.options -> {for: sure}

var output = ap.parse(
  ['--for', 'sure'],
  ap.Options(
    boolean: ['for']
  ),
)
// output.primary -> [sure]
// output.options -> {for: true}
```

#### `List<List<String>> options.alias`

List of lists with each of them containing alias keys for options.

```dart
var output = ap.parse(['--save'])
// output.primary -> []
// output.options -> {save: true}

var output = ap.parse(
  ['-s'],
  ap.Options(
    alias: [
      ['save', 's']
    ],
  ),
)
// output.primary -> []
// output.options -> {s: true, save: true}
```

#### `Map<String, dynamic> options.defaults`

Default values for options, which will be merged with the parsed output.

```dart
var output = ap.parse(['npm', 'i', 'react'])
// output.primary -> [npm, i, react]
// output.options -> {}

var output = ap.parse(
  ['npm', 'i', 'react'],
  ap.Options(
    defaults: {
      'save': true
    }
  ),
)
// output.primary -> [npm, i, react]
// output.options -> {save: true}
```

## License

MIT &copy; Frenco Jobs
