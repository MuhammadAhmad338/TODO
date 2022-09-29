import 'package:hive_flutter/hive_flutter.dart';

class Hivedatabase {
  List listoftiles = [];
  final _myBox = Hive.box("hivedatabase");

  initilizeData() {
    listoftiles = [
      ["Do Exerices", false],
      ["Code App", false]
    ];
  }

  loadingDatabase() {
    listoftiles = _myBox.get("TODOLIST");
  }

  updateDatabase() {
    _myBox.put("TODOLIST", listoftiles);
  }
}
