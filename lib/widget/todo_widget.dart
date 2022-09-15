import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import 'package:lastaginfirebase/utils.dart';
import 'package:lastaginfirebase/page/edit_todo_page.dart';



class TodoWidget extends StatefulWidget {
  const TodoWidget({required this.todo ,Key? key}) : super(key: key);
  final Todo todo;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {



  Widget buildTodo(BuildContext context) => GestureDetector(
    onTap: ()=> editTodo(context, widget.todo),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            value: widget.todo.isDone,
            onChanged: (_) {
              final provider = Provider.of<TodosProvider>(context,listen: false);
              final isDone = provider.toggleTodoStatus(widget.todo);

              Utils.showSnackBar(context,
                  isDone? '욜?다함?' : '아직 다 안했더?');


            },
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                  ),
                ),
                if (widget.todo.description.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      widget.todo.description,
                      style: TextStyle(fontSize: 20, height: 1.5),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    ),
  );

  deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context,listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context,'너 금방 삭제했어');
  }

  editTodo(BuildContext context, Todo todo) {
    return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    ),
  );}

  @override


  Widget build(BuildContext context) => Container(

    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        key: Key(widget.todo.id!), //todo : Todo
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (context) =>{
                editTodo(context,widget.todo)
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (context) =>{
                deleteTodo(context,widget.todo)
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        child: buildTodo(context),
      ),
    ),
  );
}

