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


  /// 안한놈
  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  /// 한놈
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos as List<Todo>;
        notifyListeners();
      });


  //복습할 날짜받은후, 생성
  void addTodo(Todo todo) {
       FirebaseApi.createTodo(todo);
  }


  void removeTodo(Todo todo) {
    final Map<dynamic, Todo> todomap = todos.asMap();
    todomap.forEach((key, value) {
      if (todo.title == value.title) {
        FirebaseApi.deleteTodo(value);
      }
    });
  }
// 나 다했져 - 이것만 전체다 아니고 하나만. //삭제아님.
  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    final Map<dynamic, Todo> todomap = todos.asMap();
    todomap.forEach((key, value) {
      if (todo.title == value.title) {
        value.title = title;
        value.description = description;
        FirebaseApi.updateTodo(value);
      }
    });
  }

  // 타이머 수정
  void updatetimer(todo, newtimer) {

    todo.timer = newtimer;
    FirebaseApi.updateTodo(todo);

  }

  











}