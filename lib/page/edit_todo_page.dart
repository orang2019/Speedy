import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/model/todo.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:lastaginfirebase/widget/todo_form_widget.dart';


class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {    // is not empty
      return; // validate 체크 안해도됨.
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      // final todos = provider.todos;
      // final Map<dynamic, Todo> todomap = todos.asMap();
      // todomap.forEach((key, value) {if(widget.todo.title == value.title){
      //   provider.updateTodo(value, value.title, value.description);
      // }});

      provider.updateTodo(widget.todo, title, description);
      return Navigator.of(context).pop();
      //todo : 정말 지우겠습니까 ? 팝업창


  }}


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Edit Todo'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            final provider = Provider.of<TodosProvider>(context, listen: false);
            provider.removeTodo(widget.todo);

            Navigator.of(context).pop();
          },
        )
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: TodoFormWidget(
          title: title,
          description: description,
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
          onSavedTodo: saveTodo,
        ),
      ),
    ),
  );
}


