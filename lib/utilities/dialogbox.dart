import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  const Dialogbox(
      {super.key,
      required this.controller,
      required this.onSaved,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              decoration: const InputDecoration(
                  hintText: "Add a task...", border: OutlineInputBorder()),
              controller: controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    onSaved();
                  },
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: () {
                    onCancel();
                  },
                  child: const Text("Cancel"),
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}
