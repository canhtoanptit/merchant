class Todo {
  int id;
  String name;
  String description;
  String completeBy;
  int priority;

  Todo(this.name, this.description, this.completeBy, this.priority);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'completeBy': completeBy,
      'priority': priority,
    };
  }

  Todo.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.description = map['description'];
    this.completeBy = map['completeBy'];
    this.priority = map['priority'];
  }
}
