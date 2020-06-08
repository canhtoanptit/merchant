import 'package:flutter/material.dart';
import 'package:merchant/helpers/todo_bloc.dart';
import 'package:merchant/models/todo_model.dart';
import 'package:merchant/pages/todo_page.dart';

class TodoDetail extends StatelessWidget {
  final Todo todo;
  final bool isNew;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtCompleteBy = TextEditingController();
  final TextEditingController txtPriority = TextEditingController();
  final TodoBloc bloc;

  TodoDetail(this.todo, this.isNew) : bloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    final double padding = 20.0;
    txtName.text = todo.name;
    txtDescription.text = todo.description;
    txtCompleteBy.text = todo.completeBy;
    txtPriority.text = todo.priority.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text('hello world!'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: txtName,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Name'),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: txtDescription,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Description'),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: txtCompleteBy,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Complete by'),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: TextField(
                    controller: txtPriority,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Priority',
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text('Save'),
                    onPressed: () {
                      save().then((_) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => TodoPage()),
                            (Route<dynamic> route) => false,
                          ));
                    },
                  )),
            ],
          ),
        ));
  }

  Future save() async {
    todo.name = txtName.text;
    todo.description = txtDescription.text;
    todo.completeBy = txtCompleteBy.text;
    todo.priority = int.tryParse(txtPriority.text);
    if (isNew) {
      bloc.todoInsertSink.add(todo);
    } else {
      bloc.todoUpdateSink.add(todo);
    }
  }
}
