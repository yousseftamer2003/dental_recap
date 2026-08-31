import 'package:pwa_demo/models/note_item.dart';
import 'package:pwa_demo/models/task_item.dart';

String displayName = 'Alex';

final List<TaskItem> tasks = [
  TaskItem(id: '1', title: 'Reply to clinic emails'),
  TaskItem(id: '2', title: 'Prep afternoon cases', done: true),
  TaskItem(id: '3', title: 'Pick up lab work'),
];

final List<NoteItem> notes = [
  NoteItem(
    id: '1',
    title: 'Supply order',
    body: 'Gloves, composite, articulating paper.',
  ),
  NoteItem(
    id: '2',
    title: 'Call lab',
    body: 'Crown shade A2, due Thursday.',
  ),
];
