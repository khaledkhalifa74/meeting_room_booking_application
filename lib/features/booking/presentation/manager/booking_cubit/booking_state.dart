import '../../../data/models/booking_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}
class BookingSuccess extends BookingState {
  final List<BookingModel> bookings;

  BookingSuccess(this.bookings);
}
class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}

class BookingActionLoading extends BookingState {}
class BookingActionSuccess extends BookingState {}
class BookingActionError extends BookingState {
  final String message;

  BookingActionError(this.message);
}