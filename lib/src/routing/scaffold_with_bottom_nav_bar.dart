import 'package:clean_arch_riverpod_firebase/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
    if (index == 0) {
      context.goNamed(AppRoute.jobs.name);
    } else if (index == 1) {
      context.goNamed(AppRoute.entries.name);
    } else if (index == 2) {
      context.goNamed(AppRoute.account.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
