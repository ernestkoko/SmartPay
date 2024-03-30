import 'package:flutter/material.dart';

class SmartAnim extends StatefulWidget {
  const SmartAnim({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SmartAnim> createState() => _SmartAnimState();
}

class _SmartAnimState extends State<SmartAnim>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.0).animate(animation);

    animation.addListener(() {
      if (animation.isCompleted) {
        animation.reverse();
      } else {
        animation.forward();
      }
    });
    animation.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animation.dispose();

    super.dispose();
  }
}
