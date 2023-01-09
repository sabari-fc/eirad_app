class AttendanceHistory {
  List<Attendance>? data;
  int? page;
  int? take;
  int? numberofelements;
  int? totalPages;
  bool? hasPreviousPage;
  bool? hasNextPage;

  AttendanceHistory(
      {this.data,
      this.page,
      this.take,
      this.numberofelements,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage});

  AttendanceHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Attendance>[];
      json['data'].forEach((v) {
        data!.add(Attendance.fromJson(v));
      });
    }
    page = json['page'];
    take = json['take'];
    numberofelements = json['numberofelements'];
    totalPages = json['totalPages'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['take'] = take;
    data['numberofelements'] = numberofelements;
    data['totalPages'] = totalPages;
    data['hasPreviousPage'] = hasPreviousPage;
    data['hasNextPage'] = hasNextPage;
    return data;
  }
}

class Attendance {
  int? id;
  String? punchIn;
  String? punchOut;

  Attendance({this.id, this.punchIn, this.punchOut});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    punchIn = json['punchIn'];
    punchOut = json['punchOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['punchIn'] = punchIn;
    data['punchOut'] = punchOut;
    return data;
  }
}
