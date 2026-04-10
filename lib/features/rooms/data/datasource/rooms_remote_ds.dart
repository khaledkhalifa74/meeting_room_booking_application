import '../../../../core/api_client/api_service.dart';
import '../models/room_model.dart';

class RoomsRemoteDataSource {
  final ApiService apiService;

  RoomsRemoteDataSource(this.apiService);

  Future<List<RoomModel>> getRooms() async {
    final data = await apiService.get(
      endPoint: '/items/rooms',
    );

    List roomsList = data['data'];

    return roomsList.map((e) => RoomModel.fromJson(e)).toList();
  }
}