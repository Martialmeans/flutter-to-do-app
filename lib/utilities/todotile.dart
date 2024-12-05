import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todotile extends StatelessWidget {
  final String taskName;
  final bool? value;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;

  const Todotile(
      {super.key,
      required this.taskName,
      required this.value,
      required this.onChanged,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: deleteTask,
            icon: Icons.delete,
            backgroundColor: Theme.of(context).colorScheme.primary,
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                focusColor: Theme.of(context).colorScheme.primary,
              ),
              Text(
                taskName,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: value == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
