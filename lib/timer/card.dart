
import 'package:flutter/material.dart';
import 'package:lastaginfirebase/timer/timer.dart';



class card extends StatefulWidget {
  card(this.todo,this.title,this.description,{Key? key}) : super(key: key);
  dynamic todo;
  //todo 사용법 : (예시)Todaytasklist[index].title
  dynamic title;
  dynamic description;

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    bool isFront = true; //초기값은 앞면

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
        // ///timer
        //   Container(
        //     // Get.width/2,
        //     width: MediaQuery.of(context).size.width/2,
        //     height:  MediaQuery.of(context).size.width/2,
        //     child: Card(child: timer(widget.todo)),
        //   ),
        ///card
          Container(
            child: SafeArea(
              child: Center(
                child:
                GestureDetector(

                  onTap: (){
                    setState(() {
                      if (isFront){
                        isFront = false;
                      }
                      else{isFront = true;}

                    });
                  },
                  child: Container(
                      width: 300,
                      height: 300,
                      child: isFront
                          ?  Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.amberAccent
                          ),
                          child: Center(child: Text(widget.title)))
                          :  Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.lightBlueAccent
                          ),
                          child: Center(child:  Text(widget.description)))

                  ),),


              ),
            ),
          ),
        ],
      ),
    );
  }
}




class TodayReview extends StatefulWidget {
  TodayReview(this.task,this.title,this.note,this.time,{Key? key}) : super(key: key);
  dynamic task;
  dynamic title;
  dynamic note;
  dynamic time;



  @override
  State<TodayReview> createState() => _TodayReviewState();
}

class _TodayReviewState extends State<TodayReview> {
  bool isFront = true; //초기값은 앞면







  @override




  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              Container(
                // Get.width/2,
                width: MediaQuery.of(context).size.width/2,
                height:  MediaQuery.of(context).size.width/2,
                child: Card(child: timer(widget.task)),
              ),

              Container(
                child: SafeArea(
                  child: Center(
                    child:
                    GestureDetector(

                      onTap: (){
                        setState(() {
                          if (isFront){
                            isFront = false;
                          }
                          else{isFront = true;}

                        });
                      },
                      child: Container(
                          width: 300,
                          height: 300,
                          child: isFront
                              ?  Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.amberAccent
                              ),
                              child: Center(child: Text(widget.title)))
                              :  Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.lightBlueAccent
                              ),
                              child: Center(child: Text(widget.note)))

                      ),),


                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
