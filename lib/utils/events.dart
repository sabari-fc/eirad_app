import 'dart:collection';

import 'package:eirad_app/models/event.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<EventModel>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
      (index) => EventModel(
        checkIn: DateTime.now(),
        checkOut: DateTime.now().add(const Duration(hours: 8)),
        office: "King Fahad Branch, Al Olaya Riyadh, 12212, Saudi Arabia",
        totalHrs: 8,
        date: DateTime.now(),
      ),
    )
}..addAll({
    kToday: [
      EventModel(
        checkIn: DateTime.now(),
        checkOut: DateTime.now().add(const Duration(hours: 8)),
        office: "King Fahad Branch, Al Olaya Riyadh, 12212, Saudi Arabia",
        totalHrs: 8,
        date: DateTime.now(),
      ),

      // )
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
