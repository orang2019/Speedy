import 'package:flutter/material.dart';
import '../widget/goalWidget.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'create_event_dialog.dart';
import 'day_events_bottom_sheet.dart';
import 'event_widget.dart';
import 'day_item_widget.dart';
import 'package:intl/intl.dart';

import 'package:lastaginfirebase/provider/goals.dart';
import 'package:lastaginfirebase/provider/goal.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lastaginfirebase/provider/goal.dart';



//원하는 색 조정
// 색 = 기준을 우선순위로 둬도됨
// 갯수 = 3개? 너무 많으면 복습양많아지니까,비효율적임.
const eventColors = [
  Color(0xff82D964),
  Color(0xffE665FD),
  Color(0xffF7980B),
  Color(0xfff2d232),
  Color(0xffFC6054),
  Color(0xffBEBEBE),
];

// DateTime format
const kAppBarDateFormat = 'M';
const kMonthFormat = 'MMMM';
const kMonthFormatWidthYear = 'MMMM yyyy';
const kDateRangeFormat = 'dd-MM-yy';



class calendar_goal extends StatefulWidget {
  const calendar_goal({Key? key}) : super(key: key);

  @override
  State<calendar_goal> createState() => _calendar_goalState();
}



class _calendar_goalState extends State<calendar_goal> {
  CrCalendarController _controller = CrCalendarController();

  final _currentDate = DateTime.now();
  late String _appbarTitle ;
  late String _appbarmonth ;

  /// Set app bar text and month name over calendar.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _appbarmonth =  DateFormat(kAppBarDateFormat).format(date);
    _appbarTitle = _appbarmonth ;

  }

  void _onCalendarPageChanged(int year, int month) {
    setState(() {
      _setTexts(year, month);
    });
  }



    /// Show [CreateEventDialog] with settings for new event.
    /// [CreateEventDialog] 에서 만든 model이 event에 저장된다.

    Future<void> _addEvent() async {
      final event = await showDialog(
          context: context, builder: (context) => const CreateEventDialog());
      if (event != null) {
        _controller.addEvent(event); // 원래패키지에 있는 controller 에 저장
        // local 에도 저장 -1
        // hive 에 저장된 name은 카테고리로 사용

        addGoalProvider(
            CalendarGoal(
              name: event.name,
              begin: event.begin,
              end: event.end,
              eventColor: event.eventColor.toString(),
            )
        );
      }

    }

    // local 에도 저장 -2
  addGoalProvider(event){
    final provider = Provider.of<GoalsProvider>(context, listen: false);
    provider.addGoal(event);
  }


  /// 처음 [calendar_goal]에 들어왔을때 보여 줄 events

  List<CalendarEventModel>? listCalendarEventModel = [];

    void _initEvents() async{
      final Box goalbox = Hive.box<CalendarGoal>('goals'); //박스연다.

        if (goalbox.values.isNotEmpty){
          final Box goalbox = Hive.box<CalendarGoal>('goals');
          for (var event in goalbox.values) {
            String valueString = event.eventColor.split('(0x')[1].split(')')[0];
            listCalendarEventModel!.add(CalendarEventModel(
              name: event.name,
              begin: event.begin,
              end: event.end,
              eventColor: Color(int.parse(valueString, radix: 16)),
            ),);
          }

          _controller = CrCalendarController( // 패키지 사용법이라 이해할 필요없다. 이걸 initState 해야 event 가 보여지게 된다.
            onSwipe: _onCalendarPageChanged,
            events: listCalendarEventModel,
          );
        }

    }

    @override
    void initState() {

      _setTexts(_currentDate.year, _currentDate.month); // 오늘 날짜
      _initEvents(); // 기존에 저장한 goal 보여주기


      super.initState();
    }

    @override
    void dispose() {
      _controller.dispose(); // 메모리 아끼기 ?

      super.dispose();
    }


    @override

    Widget build(BuildContext context) {


      return Scaffold(
        appBar: AppBar(centerTitle: false,title: Text(_appbarTitle + " 월"),), // '월' 따로 빼서 고정

        body: CrCalendar(

          touchMode: TouchMode.singleTap, //  touchMode 가 singleTap 일때, 작동되게 설계하심

          firstDayOfWeek: WeekDay.monday, // 첫번째 요일
          eventsTopPadding: 35,
          maxEventLines: 3, //하루 최대 3개? 면, 색도 조정해야함.
          controller: _controller,
          initialDate: DateTime.now(),
          dayItemBuilder: (builderArgument) => DayItemWidget(properties: builderArgument), /// ?
          weekDaysBuilder: (day) => WeekDaysWidget(day: day), /// ?
          eventBuilder: (drawer) => EventWidget(drawer: drawer), /// ?
          onDayClicked: (events, day) => // 캘린더 day 클릭하면, events 와 day 정보를 얻을 수 있음.
              showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))), /// ui
              isScrollControlled: true,
              context: context,
              builder: (context) =>
                  DayEventsBottomSheet(
                    clearController : _controller, // 여기서 controller 을 가져가야 [ DayEventsBottomSheet ]가 제대로 작동 왠지 모르겠는데 [DayEventsBottomSheet] 에선 controller 가 작동안된다. 그럴리가 없는데 .. 다시 해보자
                    events: events,
                    day: day,
                    screenHeight: MediaQuery /// ui
                        .of(context)
                        .size
                        .height,
                  ))),

        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.black,
          onPressed: _addEvent,
          child: Icon(Icons.add),
        ),
      );
    }
  }
