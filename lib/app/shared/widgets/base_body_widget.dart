import 'package:flutter/material.dart';

typedef BaseBodyBuilder = Widget Function(
    BuildContext context, BoxConstraints constraints);

class BaseBodyWidget extends StatefulWidget {
  final BaseBodyBuilder builder;
  final bool isScrollable;
  final ScrollController? scrollController;

  const BaseBodyWidget({
    Key? key,
    required this.builder,
    this.scrollController,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  State<BaseBodyWidget> createState() => _BaseBodyWidgetState();
}

class _BaseBodyWidgetState extends State<BaseBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        controller: widget.scrollController,
        physics: !widget.isScrollable
            ? const NeverScrollableScrollPhysics()
            : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth),
          child: widget.builder(context, viewportConstraints),
        ),
      );
    });
  }
}
