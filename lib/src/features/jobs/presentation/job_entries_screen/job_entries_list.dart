// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_riverpod_firebase/src/common_widgets/list_item_builder.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/entry.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/presentation/job_entries_screen/entry_list_item.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/presentation/job_entries_screen/job_entries_list_controller.dart';
import 'package:clean_arch_riverpod_firebase/src/routing/app_router.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/async_valu_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:go_router/go_router.dart';

class JobEntriesList extends ConsumerWidget {
  const JobEntriesList({
    super.key,
    required this.job,
  });
  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      jobsEntriesListControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final entriesStream = ref.watch(jobEntriesStreamProvider(job));
    return ListItemsBuilder<Entry>(
      data: entriesStream,
      itemBuilder: (context, entry) {
        return DismissibleEntryListItem(
          dismissibleKey: Key('entry-${entry.id}'),
          entry: entry,
          job: job,
          onDismissed: () => ref
              .read(jobsEntriesListControllerProvider.notifier)
              .deleteEntry(entry),
          onTap: () => context.goNamed(
            AppRoute.entry.name,
            params: {'id': job.id, 'eid': entry.id},
            extra: entry,
          ),
        );
      },
    );
  }
}
