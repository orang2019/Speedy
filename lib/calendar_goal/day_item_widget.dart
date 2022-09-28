import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

const violet = Color(0xff7F51F5);

/// Colors for [EventWidget].
const eventColors = [
  Color(0xff82D964),
  Color(0xffE665FD),
  Color(0xffF7980B),
  Color(0xfff2d232),
  Color(0xffFC6054),
  Color(0xffBEBEBE),
];

/// Widget of day item cell for calendar
class DayItemWidget extends StatelessWidget {
  const DayItemWidget({
    required this.properties,
    Key? key,
  });

  final DayItemProperties properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: violet.withOpacity(0.3), width: 0.3)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4),
            alignment: Alignment.topCenter,
            child: Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: properties.isCurrentDay ? violet : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${properties.dayNumber}',
                    style: TextStyle(
                        color: properties.isCurrentDay
                            ? Colors.white
                            : violet
                            .withOpacity(properties.isInMonth ? 1 : 0.5))),
              ),
            ),
          ),
          if (properties.notFittedEventsCount > 0)
            Container(
              padding: const EdgeInsets.only(right: 2, top: 2),
              alignment: Alignment.topRight,
              child: Text('+${properties.notFittedEventsCount}',
                  style: TextStyle(
                      fontSize: 10,
                      color:
                      violet.withOpacity(properties.isInMonth ? 1 : 0.5))),
            ),
        ],
      ),
    );
  }
}