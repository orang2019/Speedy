import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lastaginfirebase/model/todo.dart';
import 'package:lastaginfirebase/utils.dart';

class FirebaseApi {

  // Todo:C
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  // Todo:R
  static Stream<List> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson) as StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List>);

  // Todo:U
  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson()); //firebase always need Json
  }

  // Todo:D
  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}