import 'dart:async';

import 'package:clean_arch_riverpod_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/presentation/edit_job_screen/job_submit_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditJobScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> submit(
      {Job? job, required String name, required int ratePerHour}) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }

    state = const AsyncLoading().copyWithPrevious(state);

    final database = ref.read(databaseProvider);
    final jobs = await database.fetchJobs(uid: currentUser.uid);
    final allLowerCaseNames =
        jobs.map((job) => job.name.toLowerCase()).toList();
    if (job != null) {
      allLowerCaseNames.remove(job.name.toLowerCase());
    }

    if (allLowerCaseNames.contains(name.toLowerCase())) {
      state = AsyncError(JobSubmitException(), StackTrace.current);
      return false;
    } else {
      final id = job?.id ?? documentIdFormCurrentDate();
      final updated = Job(id: id, name: name, ratePerHour: ratePerHour);
      state = await AsyncValue.guard(
        () => database.setJob(uid: currentUser.uid, job: updated),
      );
      return state.hasError == false;
    }
  }
}

final editJobScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<EditJobScreenController, void>(
        EditJobScreenController.new);
