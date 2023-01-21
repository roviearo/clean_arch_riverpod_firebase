import 'dart:async';

import 'package:clean_arch_riverpod_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobsScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> deleteJob(Job job) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(databaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => database.deleteJob(uid: currentUser.uid, job: job),
    );
  }
}

final jobsScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<JobsScreenController, void>(
        JobsScreenController.new);
