import 'package:eirad_app/models/event.dart';
import 'package:eirad_app/views/history/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/events.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key});

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  late final ValueNotifier<List<EventModel>> _selectedEvents;
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
    _selectedEvents.dispose();
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDay, selectedDay)) {
      setState(() {
        selectedDay = selectedDay;
        focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.now(),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(
              titleCentered: true,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              headerMargin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFA7AAAD),
                    width: 1,
                  ),
                ),
              ),
              leftChevronIcon: Row(
                children: const [
                  Icon(Icons.keyboard_double_arrow_left),
                  Text("Prev"),
                ],
              ),
              rightChevronIcon: Row(
                children: const [
                  Icon(Icons.keyboard_double_arrow_right),
                  Text("Next"),
                ],
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) =>
                  DateFormat.E().format(date).substring(0, 2),
              weekdayStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.orangeRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<List<EventModel>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return EventTile(
                    checkIn: value[index].checkIn,
                    checkOut: value[index].checkOut,
                    date: value[index].date,
                    office: value[index].office,
                    totalHrs: value[index].totalHrs.toString(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
