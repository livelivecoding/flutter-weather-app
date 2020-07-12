import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FadeIndexedStack extends StatefulWidget {
  final int currentIndex;
  final List<Widget> children;

  const FadeIndexedStack({
    Key key,
    this.currentIndex,
    this.children,
  }) : super(key: key);

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.currentIndex != oldWidget.currentIndex) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 10,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.currentIndex,
        children: widget.children,
      ),
    );
  }
}
