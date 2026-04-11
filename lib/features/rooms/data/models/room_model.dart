class RoomModel {
  final int id;
  final String name;
  final int capacity;

  RoomModel({
    required this.id,
    required this.name,
    required this.capacity,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
    );
  }
}