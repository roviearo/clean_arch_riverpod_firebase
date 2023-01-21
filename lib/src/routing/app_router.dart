import 'package:flutter/material.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onborading,
  signIn,
  emailPassword,
  jobs,
  job,
  addJob,
  editJob,
  entry,
  addEntry,
  editEntry,
  entries,
  account,
}
