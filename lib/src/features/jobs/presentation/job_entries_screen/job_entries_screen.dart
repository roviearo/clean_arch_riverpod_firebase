// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_riverpod_firebase/src/common_widgets/async_value_widget.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/presentation/job_entries_screen/job_entries_list.dart';
import 'package:clean_arch_riverpod_firebase/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:go_router/go_router.dart';

class JobsEntriesScreen extends ConsumerWidget {
  const JobsEntriesScreen({
    super.key,
    required this.jobId,
  });
  final JobID jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobStreamProvider(jobId));
    return ScaffoldAsyncValueWidget<Job>(
      value: jobAsync,
      data: (job) => JobEntriesPageContents(job: job),
    );
  }
}

class JobEntriesPageContents extends StatelessWidget {
  const JobEntriesPageContents({
    Key? key,
    required this.job,
  }) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.goNamed(
              AppRoute.editJob.name,
              params: {'id': job.id},
              extra: job,
            ),
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: JobEntriesList(job: job),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => context.goNamed(
          AppRoute.addEntry.name,
          params: {'id': job.id},
          extra: job,
        ),
      ),
    );
  }
}
