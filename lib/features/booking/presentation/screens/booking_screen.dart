import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking_application/core/theming/colors.dart';
import 'package:meeting_room_booking_application/core/theming/styles.dart';
import 'package:meeting_room_booking_application/features/booking/data/models/booking_model.dart';
import 'package:meeting_room_booking_application/features/booking/presentation/screens/widgets/booking_error_widget.dart';
import 'package:meeting_room_booking_application/features/booking/presentation/screens/widgets/booking_list_view.dart';
import '../../data/models/create_booking_request_model.dart';
import '../manager/booking_cubit/booking_cubit.dart';
import '../manager/booking_cubit/booking_state.dart';
import 'widgets/booking_form_widget.dart';

class BookingScreen extends StatefulWidget {
  final int roomId;

  const BookingScreen({super.key, required this.roomId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _nameController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();
    context.read<BookingCubit>().getBookings(widget.roomId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _getErrorMessage(String message) {
    if (message.toLowerCase().contains("network") ||
        message.toLowerCase().contains("socket")) {
      return "Check your internet connection and try again.";
    }
    return message;
  }
  // ── Helpers ────────────────────────────────────────────────────────────────

  Future<void> _refresh() async {
    await context.read<BookingCubit>().getBookings(widget.roomId);
  }

  String _formatTime(TimeOfDay t) =>
      "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  int _timeToMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  /// Returns true when the chosen slot overlaps any existing booking on the same date.
  bool _hasConflict(List bookings) {
    if (_selectedDate == null || _startTime == null || _endTime == null) {
      return false;
    }

    final dateStr = _selectedDate.toString().split(" ")[0];
    final newStart = _timeToMinutes(_startTime!);
    final newEnd = _timeToMinutes(_endTime!);

    for (final b in bookings) {
      if (b.date != dateStr) continue;

      parts(s) => s.split(":").map(int.parse).toList();

      final startParts = parts(b.startTime as String);
      final endParts = parts(b.endTime as String);

      final existStart = startParts[0] * 60 + startParts[1];
      final existEnd = endParts[0] * 60 + endParts[1];

      // Overlap when the new slot starts before the existing one ends
      // AND ends after the existing one starts.
      if (newStart < existEnd && newEnd > existStart) {
        return true;
      }
    }
    return false;
  }

  // ── Validation & submission ────────────────────────────────────────────────

  void _submit(List bookings) {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showSnack("Please enter your name.", isError: true);
      return;
    }
    if (_selectedDate == null) {
      _showSnack("Please pick a date.", isError: true);
      return;
    }
    if (_startTime == null || _endTime == null) {
      _showSnack("Please select both start and end times.", isError: true);
      return;
    }
    if (_timeToMinutes(_endTime!) <= _timeToMinutes(_startTime!)) {
      _showSnack("End time must be after start time.", isError: true);
      return;
    }
    if (_hasConflict(bookings)) {
      _showConflictDialog();
      return;
    }

    context.read<BookingCubit>().createBooking(
      CreateBookingRequestModel(
        roomId: widget.roomId,
        date: _selectedDate.toString().split(" ")[0],
        startTime: _formatTime(_startTime!),
        endTime: _formatTime(_endTime!),
        userName: name,
      ),
    );
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showConflictDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text("Time Conflict"),
          ],
        ),
        content: const Text(
          "This room is already booked for the selected time slot.\n\n"
              "Please choose a different time or date.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // ── Pickers ────────────────────────────────────────────────────────────────

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _startTime = time);
  }

  Future<void> _pickEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _endTime = time);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Room Booking")),
      body: BlocConsumer<BookingCubit, BookingState>(
        // Listen for create-booking side effects only
        listenWhen: (prev, curr) =>
        curr is BookingActionSuccess || curr is BookingActionError,
        listener: (context, state) {
          if (state is BookingActionSuccess) {
            _showSnack("Room booked successfully! 🎉");
            _nameController.clear();
            setState(() {
              _selectedDate = null;
              _startTime = null;
              _endTime = null;
            });
            context.read<BookingCubit>().getBookings(widget.roomId);
          } else if (state is BookingActionError) {
            _showSnack(state.message, isError: true);
          }
        },
        builder: (context, state) {
          // Determine the list of bookings across states
          final List<BookingModel>bookings = switch (state) {
            BookingSuccess s => s.bookings,
            _ => <BookingModel>[],
          };

          final isCreating = state is BookingActionLoading;
          final isLoadError = state is BookingError;
          final isLoading = state is BookingLoading;

          // ── Full-screen error (initial fetch failed, no cached data) ──────
          if (isLoadError && bookings.isEmpty) {
            return BookingsErrorWidget(
              message: _getErrorMessage(state.message),
              onRetry: _refresh,
            );
          }

          return Column(
            children: [
              // ── Form ───────────────────────────────────────────────────
              BookingFormWidget(
                nameController: _nameController,
                selectedDate: _selectedDate,
                startTime: _startTime,
                endTime: _endTime,
                isSubmitting: isCreating,
                onPickDate: _pickDate,
                onPickStartTime: _pickStartTime,
                onPickEndTime: _pickEndTime,
                onSubmit: () => _submit(bookings),
              ),

              // ── Section header ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                child: Row(
                  children: [
                    Text(
                      "Existing Bookings",
                      style: Styles.textStyle14,
                    ),
                    const Spacer(),
                    if (!isLoading && bookings.isNotEmpty)
                      Text(
                        "${bookings.length} booking${bookings.length > 1 ? 's' : ''}",
                        style: Styles.textStyle12,
                      ),
                  ],
                ),
              ),

              const Divider(
                height: 8,
                color: kHintColor,
              ),
              const SizedBox(height: 16),
              // ── Bookings list ───────────────────────────────────────────
              Expanded(
                  child: BookingsListView(
                    isLoading: isLoading,
                    isError: isLoadError && bookings.isEmpty,
                    bookings: bookings,
                    onRefresh: _refresh,
                  ),
              )
            ],
          );
        },
      ),
    );
  }
}