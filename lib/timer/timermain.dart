// https://velog.io/@adbr/flutter-scrolling-to-widget-focus-%ED%8A%B9%EC%A0%95-%EC%9C%84%EC%B9%98%EB%A1%9C-%EC%8A%A4%ED%81%AC%EB%A1%A4%EB%A7%81-%ED%8F%AC%EC%BB%A4%EC%8B%B1

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';  //자동스크롤
import 'package:lastaginfirebase/timer/card.dart';


// body : CarouselSlider (자동스크롤)
// bottomsheet : 타이머


class timermain extends StatelessWidget {
  timermain({required this.Todaytasklist,Key? key}) : super(key: key);
  List<dynamic> Todaytasklist;
  //todo 사용법 : (예시)Todaytasklist[index].title


  @override

  Widget build(BuildContext context) {
    List title = Todaytasklist.map((e) => e.title.toString()).toList() ;
    List description = Todaytasklist.map((e) => e.description.toString()).toList() ;


    return Scaffold(
      body:  Builder(
          builder: (context) {
            final double height = MediaQuery.of(context).size.height;

            //자동스크롤 + today task 하나씩 가져와서 timerlist.dart 의 card 가져오기
            return CarouselSlider.builder(

                      options: CarouselOptions(
                        height: height,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.vertical,
                      ),
                      itemCount: Todaytasklist.length,
                      itemBuilder: (context, index, realIdx) {

                        return card(Todaytasklist[index],title[index],description[index]);


                      });}),
    );


  }
}

//
//
// class todayreview extends StatelessWidget {
//   todayreview(this.Todaytasklist,this.Todaytitlelist,this.Todaynotelist,this.Todaytimelist,{Key? key}) : super(key: key);
//   List<dynamic> Todaytasklist;  //오늘날짜의 task
//   List<dynamic> Todaytitlelist; //오늘날짜의 title
//   List<dynamic> Todaynotelist;  //오늘날짜의 note
//   List<dynamic> Todaytimelist;  //오늘날짜의 time
//
//
//   final List<String> list = [];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(),//타미어
//
//         //자동스크롤 + today task 하나씩 가져와서 timerlist.dart 의 card 가져오기
//         body: Builder(
//             builder: (context) {
//               final double height = MediaQuery.of(context).size.height;
//               return  ValueListenableBuilder<Box<Task>>(
//
//                   valueListenable: Hive.box<Task>("tasks").listenable(),
//
//                   builder: (context, box, _ ) {
//
//                     return CarouselSlider.builder(
//
//                         options: CarouselOptions(
//                           height: height,
//                           viewportFraction: 1.0,
//                           enlargeCenterPage: false,
//                           scrollDirection: Axis.vertical,
//                         ),
//                         itemCount: Todaytasklist.length,
//                         itemBuilder: (context, index, realIdx) {
//
//                           return TodayReview(Todaytasklist[index],Todaytitlelist[index],Todaynotelist[index],Todaytimelist[index]);
//
//
//
//                         });});}));} }







//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: ValueListenableBuilder<Box<Task>>(
//           valueListenable: Hive.box<Task>("tasks").listenable(),
//
//           builder: (context, box, _ ) {
//
//             Box<Task> taskbox = Hive.box<Task>('tasks');
//             List<Task> taskList = taskbox.values.toList(); //리스트형태로 Task의 value 모두 가져오기
//
//
//             Set setDate = taskList.map((e) => e.creation_data).toSet(); //set 이라 서로다른 날짜가져옴.
//             List<dynamic> listDate = setDate.toList(); //list로 다시바꿈.    [ "8/27/22", "8/28/22" ..... ]
//
//
//             List<List<Task>> ListTask = [];
//             List<List<String?>> ListTaskTitle = [];
//             List<List<String?>> ListTaskNote = [];
//             //List<List<String?>> ListTaskTime = [];
//
//
//             for (String i in  listDate){
//
//               List<Task> newlist = taskList.where((e) => e.creation_data==i ).toList(); // 날짜와 같은 Task
//
//
//               List<String?> newlistTitle = newlist.map((e) => e.title).toList(); // Task중에 title
//               List<String?> newlistNote = newlist.map((e) => e.note).toList(); // Task중에 note
//               //List<String?> newlistTime = newlist.map((e) => e.time).toList(); // Task중에 time
//
//
//               ListTaskTitle.add(newlistTitle); // [["8/26/22"title],["8/27/22"title] ]
//               ListTaskNote.add(newlistNote); // [["8/26/22"note],["8/27/22"note] ]
//
//
//               //ListTaskTime.add(newlistTime); // [["8/26/22"time],["8/27/22"time] ]
//
//               ListTask.add(newlist); // [["8/26/22"task ],["8/27/22"task], ... 오늘총8개 ,내일16개,.... ]
//
//             }
//
//
//
//             return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: ListTask.length, //8개인데, 인덱스하나안의 요소가 다 사라지면
//                 itemBuilder: (context, index) {
//                   List<String?> a = ListTaskTitle[index].toList();
//                   List<String?> c = ListTaskNote[index].toList();
//                  // List<String?> d = ListTaskTime[index].toList();
//                   List<Task> b = ListTask[index].toList();
//
//
//                   return Column(
//                     children: [
//                       Container(width: 10,height: 10,),
//
//                       ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: b.length,
//                           itemBuilder: (context, i) {
//                             return TodayReview(b[i],a[i]!, c[i]!);
//                           }
//                       ),
//
//                       Container(width: 10,height: 10,),
//
//                     ],
//                   );
//                 });
//           }),
//
//     );
//   }
// }
//
//
//
//
//
//
// // //map으로 돌리면서 key와 value print
// // newList!.forEach((e) { e.forEach((key, value) {
// //
// //   Container(
// //     child: Column(
// //       children: [
// //         Text("복습할날짜 = ${key}"),
// //         value.forEach((element) { })
// //         SizedBox(
// //           child: Column(
// //             children: [
// //             ],
// //           ),
// //         )
// //
// //       ],
// //     ),
// //   )
// // })})
//




