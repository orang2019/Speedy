// import 'package:flutter/material.dart';
// import 'package:cr_calendar/cr_calendar.dart';
//
// class goalWidget extends StatefulWidget {
//   const goalWidget({Key? key}) : super(key: key);
//
//   @override
//   State<goalWidget> createState() => _goalWidgetState();
// }
//
// class _goalWidgetState extends State<goalWidget> {
//   final CrCalendarController _controller = CrCalendarController();
//
//   @override
//   void initState() {
//     // _setTexts(_currentDate.year, _currentDate.month);
//     // _createExampleEvents();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//
//   @override
//
//   Widget build(BuildContext context) {
//     return  CrCalendar(
//       controller: _controller,
//       initialDate:DateTime.now(),
//       dayItemBuilder: (builderArgument) => DayItemWidget(properties: builderArgument),
//       weekDaysBuilder: (day) => WeekDaysWidget(day: day),
//       eventBuilder: (drawer) => EventWidget(drawer: drawer),
//
//       // onDayClicked :
//     );
//   }
// }
