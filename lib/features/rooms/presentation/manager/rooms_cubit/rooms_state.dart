import '../../../data/models/room_model.dart';

abstract class RoomsState {}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsSuccess extends RoomsState {
  final List<RoomModel> rooms;

  RoomsSuccess(this.rooms);
}

class RoomsError extends RoomsState {
  final String message;

  RoomsError(this.message);
}