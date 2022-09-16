import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:lastaginfirebase/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Center(
      child: Text(
        'No todos.',
        style: TextStyle(fontSize: 20),
      ),
    )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16), //card간 분리
      separatorBuilder: (context, index) => Container(height: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return TodoWidget(list:todos,todo: todo,index: index);
      },
    );
  }
}