import 'package:flutter/material.dart';
import 'package:lastaginfirebase/widget/todo_form_widget.dart';
import 'package:lastaginfirebase/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>(); // validation - text,note 입력했는지 확인
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Todo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          TodoFormWidget(
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedTodo: addTodo,

          ),
        ],
      ),
    ),
  );
//todo: 저장버튼 누르면 ?
  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }





    }
}