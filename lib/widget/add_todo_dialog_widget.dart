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

      //저장버튼 누르면 -> 그날날짜 +1,2,5,7,15,30,60,120도 똑같이 복사
      var now = new DateTime.now(); //잠시 저장= 원랜 오늘 복습 ㄴ?

      var reviewday = [1,5,7,15,30,60,120]; // 복습날짜 리스트
      var reviewdayList= reviewday.map((e) => now.add(new Duration(days: e))).toList(); //[review1,review5, .. ]


      final provider = Provider.of<TodosProvider>(context, listen: false);

      reviewdayList.forEach((element) {
        provider.addTodo(
            Todo(
                id: DateTime.now().toString(),
                title: title,
                description: description,
                createdTime: element,
                timer: "0",
                index:reviewdayList.indexOf(element) // reviewday index
            )
        );
      }

      );








      //
      // var review2 = now.add(new Duration(days: 1));
      // var review5 = now.add(new Duration(days: 5));
      // var review7 = now.add(new Duration(days: 7));
      // var review15 = now.add(new Duration(days: 15));
      // var review30 = now.add(new Duration(days: 30));
      // var review60 = now.add(new Duration(days: 60));
      // var review120 = now.add(new Duration(days: 120));
      //
      // final todo = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: now,
      //   timer: "0"
      // );final todo2 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: review2,
      //   timer: "0"
      // );final todo5 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: review5,
      //     timer: "0"
      // );final todo7 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: review7,
      //     timer: "0"
      // );final todo15 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: review15,
      //     timer: "0"
      // );final todo30 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: review30,
      //     timer: "0"
      // );final todo60 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime: review60,
      //     timer: "0"
      // );final todo120 = Todo(
      //   id: DateTime.now().toString(),
      //   title: title,
      //   description: description,
      //   createdTime:review120,
      //     timer: "0"
      // );
      // final provider = Provider.of<TodosProvider>(context, listen: false);
      // provider.addTodo(todo); //실험용
      // provider.addTodo(todo2);
      // provider.addTodo(todo5);
      // provider.addTodo(todo7);
      // provider.addTodo(todo15);
      // provider.addTodo(todo30);
      // provider.addTodo(todo60);
      // provider.addTodo(todo120);

      Navigator.of(context).pop();
    }





    }
}