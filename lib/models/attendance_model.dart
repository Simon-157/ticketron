
class EventAttendance {
  String attendanceId;
  String eventId;
  String userId;
  DateTime timestamp;
  AttendanceStatus attendanceStatus;
  PaymentStatus paymentStatus;

  EventAttendance({
    required this.attendanceId,
    required this.eventId,
    required this.userId,
    required this.timestamp,
    required this.attendanceStatus,
    required this.paymentStatus,
  });

  factory EventAttendance.fromJson(Map<String, dynamic> json) {
    return EventAttendance(
      attendanceId: json['attendanceId'],
      eventId: json['eventId'],
      userId: json['userId'],
      timestamp: DateTime.parse(json['timestamp']),
      attendanceStatus: AttendanceStatus.values[json['attendanceStatus']],
      paymentStatus: PaymentStatus.values[json['paymentStatus']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendanceId': attendanceId,
      'eventId': eventId,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'attendanceStatus': attendanceStatus.index,
      'paymentStatus': paymentStatus.index,
    };
  }
}

enum AttendanceStatus {
  attended,
  notAttended,
  canceled,
}

enum PaymentStatus {
  notPaid,
  paid,
  pendingVerification,
}
