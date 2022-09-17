import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/model/todo.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:html_editor_enhanced/html_editor.dart';





HtmlEditorController controller = HtmlEditorController();



class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}



class _EditTodoPageState extends State<EditTodoPage> {



  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {    // is not empty
      return; // validate 체크 안해도됨.
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description);
      return Navigator.of(context).pop();



  }}

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(


      body: Column(
        children: [
        HtmlEditor(
        controller: controller, //required
        htmlEditorOptions: HtmlEditorOptions(
          hint: "Your text here...",
          //initalText: "text content initial, if any",
        ),
        otherOptions: OtherOptions(
          height: 400,
        ),
      )])


          // Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Form(
          //     key: _formKey,
          //     child: TodoFormWidget(
          //       title: title,
          //       description: description,
          //       onChangedTitle: (title) => setState(() => this.title = title),
          //       onChangedDescription: (description) =>
          //           setState(() => this.description = description),
          //       onSavedTodo: saveTodo,
          //     ),
          //   ),
          // ),
      //   ],
      // ),
    ),
  );
}


