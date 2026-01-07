import 'package:flutter/material.dart';
import '../models/task.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Task> taskList = [
    Task(id: 1, title: 'Купить хлеб'),
    Task(id: 2, title: 'Изучить Flutter'),
    Task(id: 3, title: 'Создать To-Do App')
  ];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text('To-Do'),),
      body: ListView.builder(itemCount: taskList.length,
          itemBuilder: (context, index) {
            final task = taskList[index];

            return ListTile(
                leading: Checkbox(value: task.isDone,
                    onChanged: (_) => toggleTask(task)),
                title: Text(task.title,
                  style: TextStyle(decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : null),),
                trailing: IconButton(onPressed: () {
                  setState(() {
                    taskList.removeAt(index);
                  });
                }, icon: const Icon(Icons.delete))
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: _showAddTaskDialod,
        child: const Icon(Icons.add),),
    );
  }

  void _showAddTaskDialod() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('новая задача'),
        content: TextField(
          controller: _taskController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Введите текст задачи'),
        ),
        actions: [
          TextButton(onPressed: _addTask, child: const Text('Добавить'))
        ],
      );
    });
  }

  void toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _addTask() {
    final text = _taskController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      taskList.add(
          Task(id: DateTime.now().millisecondsSinceEpoch, title: text)
      );
    });

    _taskController.clear();
    Navigator.pop(context);
  }
}
