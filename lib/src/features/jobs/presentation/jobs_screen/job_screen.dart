// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:clean_arch_riverpod_firebase/src/common_widgets/list_item_builder.dart';
import 'package:clean_arch_riverpod_firebase/src/constants/strings.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/presentation/jobs_screen/job_screen_controller.dart';
import 'package:clean_arch_riverpod_firebase/src/routing/app_router.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/async_valu_ui.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.goNamed(AppRoute.addJob.name),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            jobsScreenControllerProvider,
            (_, state) => state.showAlertDialogOnError(context),
          );
          final jobAsyncValue = ref.watch(jobsStreamProvider);
          return ListItemsBuilder(
            data: jobAsyncValue,
            itemBuilder: (context, job) => Dismissible(
              key: Key('job-${job.id}'),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => ref
                  .read(jobsScreenControllerProvider.notifier)
                  .deleteJob(job),
              child: JobListTile(
                job: job,
                onTap: () => context.goNamed(
                  AppRoute.job.name,
                  params: {
                    'id': job.id,
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class JobListTile extends StatelessWidget {
  const JobListTile({
    Key? key,
    required this.job,
    this.onTap,
  }) : super(key: key);
  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
