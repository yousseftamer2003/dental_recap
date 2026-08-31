import 'package:flutter/material.dart';
import 'package:pwa_demo/data/database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController(text: displayName);

  @override
  Widget build(BuildContext context) {
    final openCount = tasks.where((t) => !t.done).length;
    final doneCount = tasks.where((t) => t.done).length;

    return Scaffold(
      appBar: AppBar(title: const Text('You')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 36,
            child: Text(displayName[0].toUpperCase()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Display name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              setState(() {
                displayName = value.trim().isEmpty ? 'Alex' : value.trim();
              });
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _box('Open', '$openCount')),
              const SizedBox(width: 12),
              Expanded(child: _box('Done', '$doneCount')),
              const SizedBox(width: 12),
              Expanded(child: _box('Notes', '${notes.length}')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _box(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 24)),
            Text(label),
          ],
        ),
      ),
    );
  }
}
