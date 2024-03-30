import 'dart:developer';

import 'package:flutter/material.dart';
class AppSlideAnimation extends StatefulWidget {
  const AppSlideAnimation({
    super.key,
    required this.child,
    this.beginOffset,
    this.endOffset,
    this.milliseconds,
  });

  final Widget child;
  final Offset? beginOffset;
  final Offset? endOffset;
  final int? milliseconds;

  @override
  State<AppSlideAnimation> createState() => _AppSlideAnimationState();
}

class _AppSlideAnimationState extends State<AppSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.milliseconds ?? 1300),
        vsync: this);
    _animation = Tween<Offset>(
        begin: widget.beginOffset ?? Offset.zero,
        end: widget.endOffset ?? Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const ElasticOutCurve(1.0),
      ),
    );
    _animationController.addListener(() {
      // log("LISTENR");
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSlideAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _animation = Tween<Offset>(
        begin: widget.beginOffset ?? Offset.zero,
        end: widget.endOffset ?? Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _animationController.forward();
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
