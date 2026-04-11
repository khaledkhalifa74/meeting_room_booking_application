import '../../../../core/api_client/api_service.dart';
import '../models/booking_model.dart';
import '../models/create_booking_request_model.dart';

class BookingRemoteDataSource {
  final ApiService apiService;

  BookingRemoteDataSource(this.apiService);

  Future<List<BookingModel>> getBookings(int roomId) async {
    final data = await apiService.get(
      endPoint: '/items/bookings?filter[room_id]=$roomId',
    );

    List list = data['data'];
    return list.map((e) => BookingModel.fromJson(e)).toList();
  }

  Future<void> createBooking(CreateBookingRequestModel model) async {
    await apiService.post(
      endPoint: '/items/bookings',
      data: model.toJson(),
    );
  }
}