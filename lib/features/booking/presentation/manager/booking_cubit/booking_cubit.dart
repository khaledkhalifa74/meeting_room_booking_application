import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api_client/api_failure.dart';
import '../../../data/models/create_booking_request_model.dart';
import '../../../data/repos/booking_repo.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo repo;

  BookingCubit(this.repo) : super(BookingInitial());

  List bookingsCache = [];

  Future<void> getBookings(int roomId) async {
    emit(BookingLoading());

    try {
      final bookings = await repo.getBookings(roomId);
      bookingsCache = bookings;
      emit(BookingSuccess(bookings));
    } catch (e) {
      if (e is Failure) {
        emit(BookingError(e.message));
      } else {
        emit(BookingError("Unexpected error"));
      }
    }
  }

  bool isTimeSlotAvailable({
    required String date,
    required String start,
    required String end,
  }) {
    final startNew = _toMinutes(start);
    final endNew = _toMinutes(end);

    for (final b in bookingsCache) {
      if (b.date != date) continue;

      final startOld = _toMinutes(b.startTime);
      final endOld = _toMinutes(b.endTime);

      // overlap check
      if (startNew < endOld && endNew > startOld) {
        return false;
      }
    }
    return true;
  }

  int _toMinutes(String time) {
    final parts = time.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  Future<void> createBooking(CreateBookingRequestModel model) async {
    emit(BookingActionLoading());

    try {
      if (!isTimeSlotAvailable(
        date: model.date,
        start: model.startTime,
        end: model.endTime,
      )) {
        emit(BookingError("This time slot is already booked"));
        return;
      }

      await repo.createBooking(model);

      await getBookings(model.roomId);

      emit(BookingActionSuccess());
    } catch (e) {
      if (e is Failure) {
        emit(BookingError(e.message));
      } else {
        emit(BookingError("Unexpected error"));
      }
    }
  }
}