import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/database/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_to_do_app/utilities/dialogbox.dart';
import 'package:flutter_to_do_app/utilities/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _mybox = Hive.box('hive_box');

  Database dB = Database();

  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      dB.createInitialData();
    } else {
      dB.loadDatabase();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      dB.toDoList[index][1] = !dB.toDoList[index][1];
    });
    dB.updateDatabase();
  }

  void createNewTask() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialogbox(
            controller: _controller,
            onSaved: () {
              setState(() {
                dB.toDoList.add([_controller.text, false]);
                _controller.clear();
              });
              Navigator.pop(context);
              dB.updateDatabase();
            },
            onCancel: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          );
        },
      );
    });
  }

  void deleteFunction(index) {
    setState(() {
      dB.toDoList.removeAt(index);
    });
    dB.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("To do"), Icon(Icons.note_rounded)],
        ),
        centerTitle: true,
      ),
      // Create list view builder to create the todo tiles
      body: ListView.builder(
        itemCount: dB.toDoList.length,
        itemBuilder: (context, index) {
          return Todotile(
            taskName: dB.toDoList[index][0],
            value: dB.toDoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            deleteTask: (context) {
              deleteFunction(index);
            },
          );
        },
      ),
      // floating action button to add tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}