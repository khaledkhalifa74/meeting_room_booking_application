class BookingModel {
  final int id;
  final int roomId;
  final String date;
  final String startTime;
  final String endTime;
  final String userName;

  BookingModel({
    required this.id,
    required this.roomId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.userName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      roomId: json['room_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      userName: json['user_name'],
    );
  }
}