// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_riverpod_firebase/src/common_widgets/date_time_picker.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/presentation/entry_screen/entry_screen_controller.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/async_valu_ui.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/entry.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:go_router/go_router.dart';

class EntryScreen extends ConsumerStatefulWidget {
  const EntryScreen({
    super.key,
    required this.jobId,
    this.entryId,
    this.entry,
  });
  final JobID jobId;
  final EntryID? entryId;
  final Entry? entry;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  late String _comment;

  @override
  void initState() {
    super.initState();
    final start = widget.entry?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.entry?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    _comment = widget.entry?.comment ?? '';
  }

  Entry _entryFromState() {
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute);
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    final id = widget.entry?.id ?? documentIdFormCurrentDate();
    return Entry(
      id: id,
      jobId: widget.jobId,
      start: start,
      end: end,
      comment: _comment,
    );
  }

  Future<void> _setEntryAndDismiss() async {
    final entry = _entryFromState();
    final success =
        await ref.read(entryScreenControllerProvider.notifier).setEntry(entry);
    if (success && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      entryScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry != null ? 'Edit Entry' : 'New Entry'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _setEntryAndDismiss(),
            child: Text(
              widget.entry != null ? 'Update' : 'Create',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildStartDate(),
              _buildEndDate(),
              const SizedBox(height: 8),
              _buildDuration(),
              const SizedBox(height: 8),
              _buildComment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End',
      selectedDate: _endDate,
      selectedTime: _endTime,
      onSelectedDate: (date) => setState(() => _endDate = date),
      onSelectedTime: (time) => setState(() => _endTime = time),
    );
  }

  Widget _buildDuration() {
    final currentEntry = _entryFromState();
    final durationFormatted = Format.hours(currentEntry.durationInHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Duration $durationFormatted',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildComment() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _comment),
      decoration: const InputDecoration(
        labelText: 'Comment',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      keyboardAppearance: Brightness.light,
      style: const TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (comment) => _comment = comment,
    );
  }
}
