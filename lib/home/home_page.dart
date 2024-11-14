import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/utilities/dialogbox.dart';
import 'package:flutter_to_do_app/utilities/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List items = [
    ["run a marathon", false],
    ["Drink atleast 250ml water", false]
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      items[index][1] = !items[index][1];
    });
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
                items.add([_controller.text, false]);
                _controller.clear();
              });
              Navigator.pop(context);
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
      items.removeAt(index);
    });
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
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Todotile(
            taskName: items[index][0],
            value: items[index][1],
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
