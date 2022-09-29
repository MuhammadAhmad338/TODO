// ignore_for_file: file_names, unused_field, avoid_print
import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database/Database/hivedatabase.dart';
import 'package:local_database/Utils/dialogBox.dart';
import 'package:local_database/Utils/toDoList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  Hivedatabase db = Hivedatabase();
  final _mybox = Hive.box("hivedatabase");

  onChangedFunction(bool? value, int index) {
    setState(() {
      db.listoftiles[index][1] = !db.listoftiles[index][1];
    });
    db.updateDatabase();
  }

  createATask() {
    return showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: textEditingController, onSubmit: submitTheTask);
        });
  }

  submitTheTask() {
    setState(() {
      db.listoftiles.add([textEditingController.text, false]);
      textEditingController.clear();
    });
    Navigator.pop(context);
    db.updateDatabase();
  }

  deleteTheTask(int index) {
    setState(() {
      db.listoftiles.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.initilizeData();
    } else {
      db.loadingDatabase();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "TO DO",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: SafeArea(
          child: ListView.builder(
              itemCount: db.listoftiles.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.listoftiles[index][0],
                  isCompleted: db.listoftiles[index][1],
                  onChanged: (value) {
                    onChangedFunction(value, index);
                  },
                  delete: (context) {
                    deleteTheTask(index);
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: createATask,
        child: const Icon(Icons.add),
      ),
    );
  }
}


 //Hive instance
  /*
  final _myBox = Hive.box("testBox");

  void write() {
    _myBox.put(1, "Ahmad");
  }

  void read() {
    print(_myBox.get(1));
  }

  void delete() {
    _myBox.delete(1);
  }
*/