import 'arg_parser.dart';
import 'dart:io';


void main(List<String> arguments) {

  // 1. Указываем путь к лог-файлу (ваш test.log)
  final String? path = makeUsageOfThese(arguments); //maybe right path, maybe not, maybe null
  if(path == null) return;
  late final File? logFile; //define logFile here and not inside try-catch, because I use it below
  try{
    logFile = File(path);
  } catch (e){
    print('P1.line14 Probably there is not such file. $e');
    return;
  }
  
  // 2. Читаем файл построчно
  late final List<String> lines;
  try{
    lines = logFile.readAsLinesSync();
  } catch (e){
    print("P2.line 23 $e");
    return;
  }
  
  // 3. Фильтруем строки с "ERROR"
  final errors = lines.where((line) => line.contains('INFO')).toList();
  
  // 4. Выводим результат
  print('Найдено строк: ${errors.length}');
  errors.forEach(print);
}
