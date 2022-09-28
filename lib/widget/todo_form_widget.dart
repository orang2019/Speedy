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
    final List todo = provider.todos;
    final String previousTitle = title; // 기존에 있던 title




    return SingleChildScrollView(

      child: Column(
        children: [
          buildTitle(todo, previousTitle),
          SizedBox(height:30),
          buildDescription(),
          SizedBox(height: MediaQuery.of(context).size.height/2),
          buildButton(),
        ],
      ));
    }

  Widget buildTitle(List todo, String previousTitle) => TextFormField(

    // todo : title
    maxLines: 5,
    initialValue: title,
    onChanged: onChangedTitle,
    validator: (title) {
      Iterable notTitle = todo.where((e) => e.title == title );
      if (title!.isEmpty ) {  // 작성한 title 이 없다면
        return 'The title cannot be empty';
      }
      else if(notTitle.isNotEmpty && ('' == previousTitle)){ // 처음 만드는 title 이라면
        return '기존의 질문은 삼가하기 !';
      }
      return null; // 편집할 땐, 이전에 있던 title 사용가능.
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
    ),
  );

  Widget buildDescription() => TextFormField(
    // todo : note
    maxLines: 10,
    initialValue: description,
    onChanged: onChangedDescription,
    validator: (description) {
      if (description!.isEmpty ) {
        return 'The description candnot be empty';
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