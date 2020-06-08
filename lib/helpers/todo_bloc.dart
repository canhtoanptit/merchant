import 'dart:async';

import 'package:merchant/helpers/todo_db.dart';
import 'package:merchant/models/todo_model.dart';

class TodoBloc {
  final _todoStreamController = StreamController<List<Todo>>.broadcast();

  //for updates
  final _todoInsertController = StreamController<Todo>();
  final _todoUpdateController = StreamController<Todo>();
  final _todoDeleteController = StreamController<Todo>();

  TodoDb db;
  List<Todo> todoList;

  TodoBloc() {
    db = TodoDb();
    getTodos();
    //listen to changes:
    _todoStreamController.stream.listen(returnTodos);
    _todoInsertController.stream.listen(_addTodo);
    _todoUpdateController.stream.listen(_updateTodo);
    _todoDeleteController.stream.listen(_deleteTodo);
  }

  Stream<List<Todo>> get todos => _todoStreamController.stream;

  StreamSink<List<Todo>> get todosSink => _todoStreamController.sink;

  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;

  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;

  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  Future getTodos() async {
    List<Todo> todos = await db.getTodos();
    todoList = todos;
    todosSink.add(todos);
  }

  void _deleteTodo(Todo todo) {
    db.deleteTodo(todo).then((result) {
      getTodos();
    });
  }

  void _updateTodo(Todo todo) {
    db.updateTodo(todo).then((result) {
      getTodos();
    });
  }

  void _addTodo(Todo todo) {
    db.insertTodo(todo).then((result) {
      getTodos();
    });
  }

  List<Todo> returnTodos(todos) {
    return todos;
  }

  //in the dispose method we need to close the stream controllers.
  void dispose() {
    _todoStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }
}
