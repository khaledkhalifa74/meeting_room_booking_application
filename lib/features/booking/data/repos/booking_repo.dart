import 'package:dio/dio.dart';
import '../../../../core/api_client/api_failure.dart';
import '../data_source/booking_remote_ds.dart';
import '../models/booking_model.dart';
import '../models/create_booking_request_model.dart';

class BookingRepo {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepo(this.remoteDataSource);

  Future<List<BookingModel>> getBookings(int roomId) async {
    try {
      return await remoteDataSource.getBookings(roomId);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  Future<void> createBooking(CreateBookingRequestModel model) async {
    try {
      return await remoteDataSource.createBooking(model);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}