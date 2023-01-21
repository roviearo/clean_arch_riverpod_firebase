class JobSubmitException {
  String get title => 'Name alredy used';
  String get description => 'Please choose a different job name';

  @override
  String toString() {
    return '$title. $description';
  }
}
