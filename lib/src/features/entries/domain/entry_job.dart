import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/entry.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
