import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:lastaginfirebase/provider/goals.dart';
import 'package:provider/provider.dart';
import 'package:lastaginfirebase/provider/goal.dart';

import 'goalEditor.dart';

extension DateTimeExt on DateTime {
  String format(String formatPattern) => DateFormat(formatPattern).format(this);
}

const kAppBarDateFormat = 'M/yyyy';
const kMonthFormat = 'MMMM';
const kMonthFormatWidthYear = 'MMMM yyyy';
const kDateRangeFormat = 'dd-MM-yy';

/// Draggable bottom sheet with events for the day.
class DayEventsBottomSheet extends StatefulWidget {
  DayEventsBottomSheet({Key? key,
    required this.clearController,
    required this.screenHeight,
    required this.events,
    required this.day,
  }) : super(key: key);

  final clearController;
  List<CalendarEventModel> events;
  final DateTime day;
  final double screenHeight;


  @override
  State<DayEventsBottomSheet> createState() => _DayEventsBottomSheetState();
}

class _DayEventsBottomSheetState extends State<DayEventsBottomSheet> {

  @override

  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        maxChildSize: 0.9,
        expand: false,
        builder: (context, controller) {
          return widget.events.isEmpty
              ? const Center(child: Text('No events for this day')) //선택한 날짜의 events.isNotEmpty
              : ListView.builder(
              controller: controller,
              itemCount: widget.events.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Text(widget.day.format('dd/MM/yy')), //todo
                  );
                } else {
                  final CalendarEventModel event = widget.events[index - 1];

                  final CalendarGoal goalEvent = CalendarGoal(
                    name: event.name,
                    begin: event.begin,
                    end: event.end,
                    eventColor: event.eventColor.toString(),
                  );

                  return Slidable( //슬라이드 - 편집,삭제
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [

                          SlidableAction(
                            onPressed: (value) {
                                //todo :  팝업창대신, 안중요하니까 undo 로 놓자.

                              // 1. ui 삭제
                              var toRemove = [];
                              if(widget.clearController.events != null){ //null check

                              for (var element in widget.clearController.events!) {
                                if( (element.name== event.name ) && (element.begin==event.begin) && (element.end ==event.end ))
                                  {toRemove.add(element);}}
                              }

                              widget.clearController.events!.removeWhere((e) => e==toRemove[0]); //반복문안에 너무 많은 함수를 넣게 되면, 에러
                              widget.clearController.clearSelected(); //스케쥴 rebuild = ui rebuild 1
                              setState(() {
                                    widget.events.removeAt(index - 1) ; //삭제시, 강제로 비우기 = ui rebuild 2
                              });


                              // 2. hive 삭제
                              final provider = Provider.of<GoalsProvider>(context, listen: false);
                              provider.deleteGoal(goalEvent); //이건 잘 작동

                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),]),



                    child: Container(
                        height: 100,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Row(
                                  children: [
                                    Container(
                                      color: event.eventColor,
                                      width: 6,
                                    ),
                                    Expanded(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  event.name,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  '${event.begin.format(kDateRangeFormat)} - '
                                                      '${event.end.format(kDateRangeFormat)}',
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                )))),
                  );
                }
              });
        });
  }
}