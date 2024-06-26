import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/style.dart';
import 'package:taskati/feature/home/widgets/task_item.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key, required this.tasks, required this.value});
  final List<Task> tasks;
  final Box<Task> value;
  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          Task item = widget.tasks[index];
          return Dismissible(
            key: UniqueKey(),
            secondaryBackground: Container(
              color: AppColors.redColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete_forever_rounded,
                      color: AppColors.lightBG,
                    ),
                    Text(
                      'Delete Task',
                      style: getsmallStyle(color: AppColors.lightBG),
                    )
                  ],
                ),
              ),
            ),
            background: Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(Icons.check, color: AppColors.lightBG),
                    Text(
                      'Complete Task',
                      style: getsmallStyle(color: AppColors.lightBG),
                    )
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  widget.value.put(
                      '${item.title}-${item.date}',
                      Task(
                          id: '${item.title}-${item.date}',
                          title: item.title,
                          note: item.note,
                          date: item.date,
                          startTime: item.startTime,
                          endTime: item.endTime,
                          color: 3,
                          isComplete: true));
                });
              } else {
                setState(() {
                  widget.value.delete(
                    '${item.title}-${item.date}',
                  );
                });
              }
            },
            child: TaskItem(
              task: item,
            ),
          );
        },
      ),
    );
  }
}
