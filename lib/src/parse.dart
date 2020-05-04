part of argparser;

Arguments parse(List<String> args, [Options options]) {
  options ??= Options();
  final output = Arguments();

  if (args.isEmpty) {
    return output;
  }

  for (var i = 0; i < args.length; i++) {
    var arg = args[i];
    if (arg == '--') {
      output.primary.addAll(args.sublist(++i));
      break;
    }

    if (arg.startsWith('--')) {
      var option = arg.substring(2);
      var pattern = RegExp(r'(\w+)=(\w+)');

      if (pattern.hasMatch(option)) {
        var match = pattern.matchAsPrefix(option);

        if (options.boolean.contains(match.group(1))) {
          output.options[match.group(1)] = true;
        } else {
          output.options[match.group(1)] = match.group(2);
        }
      } else {
        if (i == args.length - 1 || options.boolean.contains(option)) {
          output.options[option] = true;
        } else {
          if (args[i + 1].startsWith('-')) {
            output.options[option] = true;
            continue;
          } else {
            output.options[option] = args[++i];
          }
        }
      }
    } else if (arg.startsWith('-')) {
      var tiny_options = arg.substring(1);

      for (var opt in tiny_options.split('')) {
        output.options[opt] = true;
      }
    } else {
      output.primary.add(arg);
    }
  }

  var aliases = options.alias;
  var keys = List.from(output.options.keys);

  for (var alias in aliases) {
    for (var key in keys) {
      if (alias.contains(key)) {
        for (var alkey in alias.where((a) => a != key)) {
          output.options[alkey] = output.options[key];
        }
      }
    }
  }

  var default_keys = List.from(options.defaults.keys);

  for (var key in default_keys) {
    if (!output.options.containsKey(key)) {
      output.options[key] = options.defaults[key];
    }
  }

  return output;
}
