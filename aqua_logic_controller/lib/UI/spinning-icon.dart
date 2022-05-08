import 'package:flutter/material.dart';

class SpinningIcon extends StatefulWidget {
  final IconData icon;
  final Duration duration;

  const SpinningIcon({
    Key? key,
    required this.icon,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  _SpinningIconState createState() => _SpinningIconState();
}

class _SpinningIconState extends State<SpinningIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Widget _child;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    _child = Icon(widget.icon, size: 64);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: _child,
    );
  }
}
