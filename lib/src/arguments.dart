part of argparser;

class Arguments {
  final List<String> primary;
  final Map<String, dynamic> options;

  Arguments({
    List<String> primary,
    Map<String, dynamic> options,
  })  : primary = primary ?? [],
        options = options ?? {};
}
