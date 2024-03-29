// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_riverpod_firebase/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    Key? key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);

  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveSliverCenter extends StatelessWidget {
  const ResponsiveSliverCenter({
    Key? key,
    this.maxContentWidth = Breakpoint.desktop,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : super(key: key);

  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
