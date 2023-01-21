// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobsDetails {
  JobsDetails({
    required this.name,
    required this.durationInHours,
    required this.pay,
  });

  final String name;
  double durationInHours;
  double pay;
}

class DailyJobDetails {
  DailyJobDetails({
    required this.date,
    required this.jobsDetails,
  });
  final DateTime date;
  final List<JobsDetails> jobsDetails;

  double get pay => jobsDetails
      .map((jobDuration) => jobDuration.pay)
      .reduce((value, element) => value + element);

  double get duration
}
