class Todo {
  int? id;
  String title;
  String? date;
  bool isCompleted;

  Todo({
    this.id,
    this.date,
    required this.title,
    this.isCompleted = false,
  });

  void toggle() {
    this.isCompleted = !isCompleted;
  }

  Todo copyWith(String? title, String? date) =>
      Todo(title: title ?? this.title, date: date ?? this.date);
}
