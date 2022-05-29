import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  final String content;
  final TextStyle? style;
  final Duration? duration;

  BlinkingText(
      {Key? key, required this.content, this.style, this.duration});

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Duration _duration = Duration(seconds: 1);

  @override
  void initState() {
    if (widget.duration != null) {
      _duration = widget.duration!;
    }

    _animationController =
        new AnimationController(vsync: this, duration: _duration);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var defaultTextStyle = DefaultTextStyle.of(context);
    var style = defaultTextStyle.style;

    if (widget.style != null) {
      style = defaultTextStyle.style.merge(widget.style!);
    }

    if (MediaQuery.boldTextOverride(context))
      style = style.merge(const TextStyle(fontWeight: FontWeight.bold));

    return FadeTransition(
      opacity: _animationController,
      child: Text(widget.content, style: style),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
