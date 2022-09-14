import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastaginfirebase/api/firebase_api.dart';
import 'package:lastaginfirebase/model/todo.dart';

// 변화가 있는 변수
class TodosProvider extends ChangeNotifier {

  // todo
  List<Todo> _todos = [
    // 아래 지우니까 null check 에러사라짐. (추가 할때 Todo() 모델사용하기 ~ !)
    // validator 왜 작동안됨 ? ㅡㅡ
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Buy Food 😋',
//       description: '''- Eggs
// - Milk
// - Bread
// - Water''',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Plan family trip to Norway',
//       description: '''- Rent some hotels
// - Rent a car
// - Pack suitcase''',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Walk the Dog 🐕',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Plan Jacobs birthday party 🎉🥳',
//     ),
  ];

    // todo
  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted => _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos as List<Todo>;
        notifyListeners();
      });


  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo)  => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }
}