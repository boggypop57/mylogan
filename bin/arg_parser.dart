import 'package:args/args.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart logan.dart <flags> [arguments]');
  print(argParser.usage);
}


String? makeUsageOfThese(List<String> args){
  final ArgParser argParser = buildParser();
  try{
    final ArgResults results = argParser.parse(args);

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return null;
    }
    if (results.flag('version')) {
      print('logan version: $version');
      return null;
    }

    // Act on the arguments provided.
    //print('Positional arguments: ${results.rest}');
    if(results.rest.length != 1){
      throw FormatException('You should put here only one argument '
       '- path to your logs, or one flag.');
    }

    return results.rest[0];
  }  on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
    return null;
  } catch (e){
    print(e);
    return null;
  }
}