import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';




class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;



  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    List todo = provider.todos;






    return SingleChildScrollView(


    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitle(todo),
        SizedBox(height: 8),
        buildDescription(),
        SizedBox(height: 32),
        buildButton(),
      ],
    ),
  );}

  Widget buildTitle(List todo) => TextFormField(



    // todo : title
    maxLines: 1,
    initialValue: title,
    onChanged: onChangedTitle,
    validator: (title) {
      Iterable notTitle = todo.where((e) => e.title == title );
      if (title!.isEmpty ) {
        return 'The title cannot be empty';
      }
      else if(notTitle.isNotEmpty){
        return '기존의 질문은 삼가하기 !';
      }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
    ),
  );

  Widget buildDescription() => TextFormField(
    // todo : note
    maxLines: 3,
    initialValue: description,
    onChanged: onChangedDescription,
    validator: (description) {
      if (description!.isEmpty ) {
        return 'The description cannot be empty';
      }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
    ),
  );

  Widget buildButton() => SizedBox(
    // todo : save
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
      onPressed: onSavedTodo,
      child: Text('Save'),
    ),
  );
}