import 'package:flutter/material.dart';
import 'package:pwa_demo/data/database.dart';
import 'package:pwa_demo/models/task_item.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    final openCount = tasks.where((t) => !t.done).length;
    final doneCount = tasks.where((t) => t.done).length;

    return Scaffold(
      appBar: AppBar(title: Text('Good day, $displayName')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            openCount == 0
                ? 'Nothing left for today.'
                : '$openCount open · $doneCount done',
          ),
          const SizedBox(height: 12),
          if (tasks.isEmpty) const Text('Add a task to start the day.'),
          for (final task in tasks)
            Card(
              child: CheckboxListTile(
                value: task.done,
                title: Text(task.title),
                secondary: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() => tasks.remove(task));
                  },
                ),
                onChanged: (_) {
                  setState(() => task.done = !task.done);
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New task'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'What needs doing?'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final text = controller.text.trim();
                Navigator.pop(context);
                if (text.isEmpty) return;
                setState(() {
                  tasks.insert(
                    0,
                    TaskItem(
                      id: DateTime.now().toString(),
                      title: text,
                    ),
                  );
                });
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
