class EventModel {
  final DateTime checkIn;
  final DateTime checkOut;
  final int totalHrs;
  final String office;
  final DateTime date;

  EventModel({
    required this.checkIn,
    required this.checkOut,
    required this.office,
    required this.totalHrs,
    required this.date,
  });
}
