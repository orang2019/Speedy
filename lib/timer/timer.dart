
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/todos.dart';

// 앱이름? 성공의 지름길 or 벼락치기
// 22/09/16
// 문제 : title이 같은 todo의 timer 모두 같게 못했다. print(widget.todo.timer)시 최초한번만 print&ui변경만 된다. 나갔다가 들어오면 변경은 되는걸 보아서 fierbase문제는 아닌듯.
// 원인 : 정확히는 모른다. provider, firebase문제도 아닌거같다. 아닌거 같은것도 사실은 문제임.
// 해결x : firebase속도가 느려서? -> timeuifunction(widget.todo.timer) 에 await걸어도 안됨. provider의 문제인듯해서 ->context.read<Store1>() 로해도 안됨.
// 마무리 : title이 같은 todo의 timer 모두 같게 못했다. 주어진 task 하나만 변경시 가능.

// 나중에 할일 : 이전복습때 마지막으로 기입된 timer 보여주기.





class timer extends StatefulWidget {
  timer(this.todo,{Key? key}) : super(key: key);
  dynamic todo;




  @override

  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {


//변수모음

  Duration duration = const Duration();
  Timer? timer;
  bool isCountDown = true; //카운트다운부터 시작
  static const CountDownDuration = Duration(seconds: 30); //todo:처음에 몇초가 적당할까?
  var count = 0; // 1분 더하기
  int timecheck = 0;
  String? totaltime;




  @override
  void initState() {
    super.initState();
    resetTimer();
    timeuifunction(widget.todo.timer);

  }




//함수 모음

  // 시간체크 ui = 00분00초로 설정, 그래서 time = seconds(초)여야함.
  totalTime(time) {
    return totaltime = time.remainder(60).toString().padLeft(2, '0');
  }

  //1분씩더하기
  void minituesAddButton() =>
      setState(() {
        count = duration.inSeconds + 60;
        duration = Duration(seconds: count);
      });

  // 타이머 초기화
  void resetTimer() {
    setState(() =>
    {
      duration = CountDownDuration,
    });
  }
  void resetTime() {
    setState(() =>
    {
      timecheck = 0
    });
  }




  // 타이머시작 -> addTime()
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) =>
    {
      addTime() //타이머 시작
    }
    );
  }



  // 1초씩 증가/감소
  addTime() {

    if (this.mounted) {
      final addSeconds = isCountDown ? -1 : 1;
      final seconds = duration.inSeconds + addSeconds;
      // 카운트다운이든 업이든 +1초
      timecheck += 1;

      setState(() {
        if (seconds < 0) {
          timer?.cancel();
          isCountDown = false;
          startTimer(); //  카운트다운끝나면 countup시작 !!
        } else {
          duration = Duration(seconds: seconds);
        }
      });
    }}


  // 00:00 UI-1
  Widget buildTimeCard({required String time }) {
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Text(
        time,

        style:  TextStyle(
            fontWeight: FontWeight.bold,
            color: (isCountDown && duration.inSeconds <= 5) || isCountDown==false ? Colors.redAccent : Colors.white,
            fontSize: 20
        ),),
    );
  }



  // 00:00 UI-2
  Widget buildTime() {
    String TwoDigits(int n) => n.toString().padLeft(2, '0');

    final M = TwoDigits(duration.inMinutes.remainder(60));
    final S = TwoDigits(duration.inSeconds.remainder(60));


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: M),
        const SizedBox(width: 8),
        buildTimeCard(time: S),
      ],
    );
  }



//timer만 업데이트
  updatetime(selectTask, newtime) async {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.updatetimer(selectTask,newtime.toString()); // firebase 업데이트=새로운값으로 덮어씌우기
  }




//  시작,끝 버튼

  Widget buildButtons() {
    var isRun = timer == null ? false : timer?.isActive; //초기값은 시작전
    if (isRun!) {
      return TextButton(onPressed: () {

        updatetime(widget.todo, timecheck);
        timeuifunction(widget.todo.timer); // 답하는데걸리는 시간을 ui에 보여주기


        timer?.cancel();

        // 저장표시ui = 바로 저장되지만 시간확인할수있게 딜레이주기
        // 딜레이 준후에

        resetTimer();
      },

          child: const Text("끝")); //TODO: 총시간save->navi.pop
    } else {
      return TextButton(onPressed: () {
        resetTime();
        isCountDown = true;
        startTimer();

      }, child: const Text("시작"));
    }
  }

  // 답하는데 걸리는 시간 ui
  var m;
  var s;

  timeuifunction(text){

    setState(() {
      m =  int.parse(text)~/60;
      s =  int.parse(text)%60;
    });

  }






  @override
  Widget build(BuildContext context) {

    // print(widget.todo.timer); 실험용



    return
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: Text("답하는데 걸린시간 = ${m}분 ${s}초 ",style: TextStyle(color: Colors.grey),),), // 끝버튼과 같이 있어야 setstate가능
            const SizedBox(height: 20),
            buildTime(), //타이머
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {isCountDown == true ? minituesAddButton() : null;}
                    , child: Text(" +1 min")), //1분추가버튼
                buildButtons(), //시작끝버튼
              ],
            ), //버튼
          ],
        ),
      );
  }

}
