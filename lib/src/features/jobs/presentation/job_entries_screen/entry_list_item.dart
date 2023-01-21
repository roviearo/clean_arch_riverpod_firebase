// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/entry.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/format.dart';

class EntryListItem extends StatelessWidget {
  const EntryListItem({
    Key? key,
    required this.entry,
    required this.job,
    this.onTap,
  }) : super(key: key);

  final Entry entry;
  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final dayOfWeek = Format.dayOfWeek(entry.start);
    final startDate = Format.date(entry.start);
    final startTime = TimeOfDay.fromDateTime(entry.start).format(context);
    final endTime = TimeOfDay.fromDateTime(entry.end).format(context);
    final durationFormatted = Format.hours(entry.durationInHours);

    final pay = job.ratePerHour * entry.durationInHours;
    final payFormatted = Format.currency(pay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              dayOfWeek,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(width: 15),
            Text(startDate, style: const TextStyle(fontSize: 18)),
            if (job.ratePerHour > 0.0) ...<Widget>[
              Expanded(
                child: Container(),
              ),
              Text(
                payFormatted,
                style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
              ),
            ],
          ],
        ),
        Row(
          children: <Widget>[
            Text('$startTime - $endTime',
                style: const TextStyle(fontSize: 16.0)),
            Expanded(child: Container()),
            Text(durationFormatted, style: const TextStyle(fontSize: 16.0)),
          ],
        ),
        if (entry.comment.isNotEmpty)
          Text(
            entry.comment,
            style: const TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}

class DismissibleEntryListItem extends StatelessWidget {
  const DismissibleEntryListItem({
    Key? key,
    required this.dismissibleKey,
    required this.entry,
    required this.job,
    this.onDismissed,
    this.onTap,
  }) : super(key: key);

  final Key dismissibleKey;
  final Entry entry;
  final Job job;
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: dismissibleKey,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed?.call(),
      child: EntryListItem(
        entry: entry,
        job: job,
        onTap: onTap,
      ),
    );
  }
}
