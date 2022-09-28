import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:lastaginfirebase/page/home_page.dart';
import 'package:lastaginfirebase/provider/todos.dart';
import 'package:lastaginfirebase/provider/goals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lastaginfirebase/controller/notificaion_controller.dart';

//hive
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lastaginfirebase/provider/goal.dart';
import 'package:lastaginfirebase/provider/goals.dart';



late Box box;

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<CalendarGoal>(CalendarGoalAdapter());//hive 세팅2
  await Hive.initFlutter(); //hive 세팅1
  box = await Hive.openBox<CalendarGoal>('goals');//hive 세팅3



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = 'Todo App';

  @override


  Widget build(BuildContext context) =>  MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => TodosProvider()),
        ChangeNotifierProvider( create: (context) => GoalsProvider()),
        ],
    child: GetMaterialApp(  // child 하위 모든것들은 TodosProvider() 에 접근 가능하다.
      debugShowCheckedModeBanner: false,

      title: title,

      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      //앱이 실행될 때 가장 먼저 실행되는 컨트롤러
      ///혹시 몰라서 컨트롤러가 꺼지지 않도록 permanent 파라미터를 true로 설정해 놓았다. 이렇게 해놓으면 어떤 일이 있어도 알아서 컨트롤러가 onDelete() 되는 경우는 없다고 한다.
      initialBinding: BindingsBuilder((){
        Get.put(NotificationController(),permanent: true);
      }),


      home: HomePage(),
    ),
  );
}