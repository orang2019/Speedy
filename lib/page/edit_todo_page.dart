import 'package:flutter/material.dart';
import 'package:lastaginfirebase/widget/todo_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/model/todo.dart';
import 'package:lastaginfirebase/provider/todos.dart';
//import 'package:html_editor_enhanced/html_editor.dart';





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

      provider.updateTodo(widget.todo, title, description);
      return Navigator.of(context).pop();

  }}

  @override

  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset : false, //ㅋㅣ보드 overflow

      body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: TodoFormWidget(
                title: title, // 이전에 저장한 title
                description: description, // 이전에 저장한 description
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTodo: saveTodo,
              ),
            ),
          ),
      ),
  );}
}


