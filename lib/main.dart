import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:lastaginfirebase/page/home_page.dart';
import 'package:lastaginfirebase/provider/todos.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
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

  // final firestore = FirebaseFirestore.instance;
  //
  // plz()async{
  //   var result = await firestore.collection('product').get();
  //   for (var doc in result.docs) {
  //     print(doc['name']);
  //   }
  // }
  //
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   plz();
  // }


  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => TodosProvider(), //변화에 대해 여러개 구독도 가능하다.
    child: MaterialApp(  // child 하위 모든것들은 TodosProvider() 에 접근 가능하다.
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      home: HomePage(),
    ),
  );
}