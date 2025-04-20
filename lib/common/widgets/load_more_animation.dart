import 'package:flutter/material.dart';

class LoadMoreAnimation extends StatefulWidget {
  const LoadMoreAnimation({super.key});

  @override
  LoadMoreAnimationState createState() => LoadMoreAnimationState();
}

class LoadMoreAnimationState extends State<LoadMoreAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dot1Opacity, _dot2Opacity, _dot3Opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _dot1Opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.33, curve: Curves.easeInOut),
    ));

    _dot2Opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.33, 0.66, curve: Curves.easeInOut),
    ));

    _dot3Opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.66, 1.0, curve: Curves.easeInOut),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _dot1Opacity,
            builder: (context, child) {
              return Opacity(opacity: _dot1Opacity.value, child: child);
            },
            child: const Dot(),
          ),
          const SizedBox(width: 4),
          AnimatedBuilder(
            animation: _dot2Opacity,
            builder: (context, child) {
              return Opacity(opacity: _dot2Opacity.value, child: child);
            },
            child: const Dot(),
          ),
          const SizedBox(width: 4),
          AnimatedBuilder(
            animation: _dot3Opacity,
            builder: (context, child) {
              return Opacity(opacity: _dot3Opacity.value, child: child);
            },
            child: const Dot(),
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
