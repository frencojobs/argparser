part of argparser;

class Options {
  final List<String> boolean;
  final List<List<String>> alias;
  final Map<String, dynamic> defaults;

  Options({
    List<String> boolean,
    List<List<String>> alias,
    Map<String, dynamic> defaults,
  })  : boolean = boolean ?? [],
        alias = alias ?? [],
        defaults = defaults ?? {};
}
