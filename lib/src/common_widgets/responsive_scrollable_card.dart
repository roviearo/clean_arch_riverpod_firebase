import 'package:clean_arch_riverpod_firebase/src/common_widgets/responsive_center.dart';
import 'package:clean_arch_riverpod_firebase/src/constants/app_sizes.dart';
import 'package:clean_arch_riverpod_firebase/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
