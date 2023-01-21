// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

typedef JobID = String;

class Job extends Equatable {
  final JobID id;
  final String name;
  final int ratePerHour;

  const Job({
    required this.id,
    required this.name,
    required this.ratePerHour,
  });

  @override
  List<Object> get props => [id, name, ratePerHour];

  @override
  bool get stringify => true;

  factory Job.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for jobId: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for jobId: $documentId');
    }
    final ratePerHour = data['ratePerHour'] as int;
    return Job(id: documentId, name: name, ratePerHour: ratePerHour);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
