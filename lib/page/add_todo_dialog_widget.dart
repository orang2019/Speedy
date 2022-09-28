import 'package:flutter/material.dart';
import 'package:lastaginfirebase/widget/todo_form_widget.dart';
import 'package:lastaginfirebase/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';


class addTodoPage extends StatefulWidget {
  const addTodoPage({Key? key}) : super(key: key);


  @override
  State<addTodoPage> createState() => _addTodoPageState();
}

class _addTodoPageState extends State<addTodoPage> {
  final _formKey = GlobalKey<FormState>(); // validation - text,note 입력했는지 확인
  String title = '';
  String description = '';

  //todo: 저장버튼 누르면 ?
  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }else {
      //저장버튼 누르면 -> 그날날짜 +1,2,5,7,15,30,60,120도 똑같이 복사
      var now = new DateTime.now(); //잠시 저장= 원랜 오늘 복습 ㄴ?

      var reviewday = [0,5,7,15,30,60,120]; // 복습날짜 리스트
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

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false, //ㅋㅣ보드 overflow

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
                    onChangedTitle: (title) => setState(() => this.title = title),
                    onChangedDescription: (description) =>
                        setState(() => this.description = description),
                    onSavedTodo: addTodo,


                  ),
          ),
        ),
      ),
    );
  }
}


//
// class AddTodoDialogWidget extends StatefulWidget {
//   @override
//   _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
// }
//
// class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
//   final _formKey = GlobalKey<FormState>(); // validation - text,note 입력했는지 확인
//   String title = '';
//   String description = '';
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Add Todo',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//           ),
//           const SizedBox(height: 8),
//           TodoFormWidget(
//             onChangedTitle: (title) => setState(() => this.title = title),
//             onChangedDescription: (description) =>
//                 setState(() => this.description = description),
//             onSavedTodo: addTodo,
//
//           ),
//         ],
//       ),
//   );
// //todo: 저장버튼 누르면 ?
//   void addTodo() {
//     final isValid = _formKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     }else {
//
//       //저장버튼 누르면 -> 그날날짜 +1,2,5,7,15,30,60,120도 똑같이 복사
//       var now = new DateTime.now(); //잠시 저장= 원랜 오늘 복습 ㄴ?
//
//       var reviewday = [0,5,7,15,30,60,120]; // 복습날짜 리스트
//       var reviewdayList= reviewday.map((e) => now.add(new Duration(days: e))).toList(); //[review1,review5, .. ]
//
//
//       final provider = Provider.of<TodosProvider>(context, listen: false);
//
//       reviewdayList.forEach((element) {
//         provider.addTodo(
//             Todo(
//                 id: DateTime.now().toString(),
//                 title: title,
//                 description: description,
//                 createdTime: element,
//                 timer: "0",
//                 index:reviewdayList.indexOf(element) // reviewday index
//             )
//         );
//       }
//
//       );
//
//
//
//
//       Navigator.of(context).pop();
//     }
//
//
//
//
//
//     }
// }