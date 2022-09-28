import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastaginfirebase/api/firebase_api.dart';
import 'package:lastaginfirebase/main.dart';
import 'package:lastaginfirebase/page/add_todo_dialog_widget.dart';
import 'package:lastaginfirebase/widget/todo_list_widget.dart';
import 'package:lastaginfirebase/widget/completed_list_widget.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/widget/calendar_widget.dart';
import 'package:lastaginfirebase/widget/TodayReviewWidget.dart';
import 'package:lastaginfirebase/calendar_goal/calendar_goal_widget.dart';

import '../widget/todo_form_widget.dart';
import 'edit_todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodayReviewWidget(),
      //Todo : 캘로 옮길것
      // TodoListWidget(), //1번째탭 페이지 //안함 -> 캘
      // CompletedListWidget(),//2번째탭 페이지 // 할 -> 캘
      CalendarWidget(),//2번째탭 페이지
    ];

    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: (){Get.to(calendar_goal());}, icon: Icon(Icons.golf_course))]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_rounded),
            label: 'TodayReview',),
          //Todo : 캘로 옮길것
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.fact_check_outlined),
          //   label: 'Todos',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.done, size: 28),
          //   label: 'Completed',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, size: 28),
            label: 'Calendar',
          ),
        ],
      ),
      body: StreamBuilder<List>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text('Something Went Wrong Try later');
              } else { // successful firebase
                var todos = snapshot.data as List<dynamic>;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () { Get.to(() => addTodoPage());},
        child: Icon(Icons.add),
      ),
    );
  }
}