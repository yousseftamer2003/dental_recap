class TaskItem {
  TaskItem({
    required this.id,
    required this.title,
    this.done = false,
  });

  String id;
  String title;
  bool done;
}
