import 'package:flutter/material.dart';
import 'package:merchant/helpers/todo_bloc.dart';
import 'package:merchant/models/todo_model.dart';
import 'package:merchant/pages/todo_detail.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodoList();
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  TodoBloc todoBloc;
  List<Todo> todos;

  @override
  void initState() {
    todoBloc = TodoBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Todo todo = Todo('name', 'description', 'completeBy', 0);
    todos = todoBloc.todoList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Container(
        child: StreamBuilder<List<Todo>>(
          stream: todoBloc.todos,
          initialData: todos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  onDismissed: (_) =>
                      todoBloc.todoDeleteSink.add(snapshot.data[index]),
                  child: ListTile(
                    title: Text("${snapshot.data[index].name}"),
                    subtitle: Text("${snapshot.data[index].description}"),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).highlightColor,
                      child: Text("${snapshot.data[index].name}"),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TodoDetail(snapshot.data[index], false)),
                        );
                      },
                    ),
                  ),
                );
              },
              itemCount: (snapshot.hasData) ? snapshot.data.length : 0,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoDetail(todo, true)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }
}
