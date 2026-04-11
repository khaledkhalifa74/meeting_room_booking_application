import 'package:dio/dio.dart';
import '../../../../core/api_client/api_failure.dart';
import '../data_source/rooms_remote_ds.dart';
import '../models/room_model.dart';

class RoomsRepo {
  final RoomsRemoteDataSource remoteDataSource;

  RoomsRepo(this.remoteDataSource);

  Future<List<RoomModel>> getRooms() async {
    try {
      return await remoteDataSource.getRooms();
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}