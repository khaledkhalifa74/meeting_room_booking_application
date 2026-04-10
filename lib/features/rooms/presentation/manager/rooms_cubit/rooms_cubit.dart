import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking_application/features/rooms/presentation/manager/rooms_cubit/rooms_state.dart';
import '../../../../../core/api_client/api_failure.dart';
import '../../../data/repo/rooms_repo.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final RoomsRepo repo;

  RoomsCubit(this.repo) : super(RoomsInitial());

  Future<void> getRooms() async {
    emit(RoomsLoading());

    try {
      final rooms = await repo.getRooms();
      emit(RoomsSuccess(rooms));
    } catch (e) {
      if (e is Failure) {
        emit(RoomsError(e.message));
      } else {
        emit(RoomsError('Unexpected error'));
      }
    }
  }
}