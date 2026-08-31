import 'package:flutter/material.dart';
import 'package:pwa_demo/core/breakpoints.dart';
import 'package:pwa_demo/data/database.dart';
import 'package:pwa_demo/models/note_item.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    var columns = 1;
    if (Breakpoints.isTablet(width)) columns = 2;
    if (Breakpoints.isDesktop(width)) columns = 3;

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet.'))
          : GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                for (final note in notes)
                  Card(
                    child: ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.body),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() => notes.remove(note));
                        },
                      ),
                      onTap: () => _editNote(note),
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editNote(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _editNote(NoteItem? existing) {
    final title = TextEditingController(text: existing?.title ?? '');
    final body = TextEditingController(text: existing?.body ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existing == null ? 'New note' : 'Edit note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: body,
                decoration: const InputDecoration(labelText: 'Details'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (existing == null) {
                    notes.insert(
                      0,
                      NoteItem(
                        id: DateTime.now().toString(),
                        title: title.text.trim().isEmpty
                            ? 'Untitled'
                            : title.text.trim(),
                        body: body.text.trim(),
                      ),
                    );
                  } else {
                    existing.title = title.text.trim().isEmpty
                        ? 'Untitled'
                        : title.text.trim();
                    existing.body = body.text.trim();
                  }
                });
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
