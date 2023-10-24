import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class AutoWidthColum extends AutoWidthFlex {
  const AutoWidthColum({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.children,
  }) : super(
          direction: Axis.vertical,
        );
}

class AutoWidthFlex extends MultiChildRenderObjectWidget {
  const AutoWidthFlex({
    super.key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    this.clipBehavior = Clip.none,
    super.children,
  }) : assert(
            !identical(crossAxisAlignment, CrossAxisAlignment.baseline) ||
                textBaseline != null,
            'textBaseline is required if you specify the crossAxisAlignment with CrossAxisAlignment.baseline');

  final Axis direction;

  final MainAxisAlignment mainAxisAlignment;

  final MainAxisSize mainAxisSize;

  final CrossAxisAlignment crossAxisAlignment;

  final TextDirection? textDirection;

  final VerticalDirection verticalDirection;

  final TextBaseline? textBaseline;

  final Clip clipBehavior;

  bool get _needTextDirection {
    switch (direction) {
      case Axis.horizontal:
        return true; // because it affects the layout order.
      case Axis.vertical:
        return crossAxisAlignment == CrossAxisAlignment.start ||
            crossAxisAlignment == CrossAxisAlignment.end;
    }
  }

  @protected
  TextDirection? getEffectiveTextDirection(BuildContext context) {
    return textDirection ??
        (_needTextDirection ? Directionality.maybeOf(context) : null);
  }

  @override
  AutoWidthColumFlex createRenderObject(BuildContext context) {
    return AutoWidthColumFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant AutoWidthColumFlex renderObject) {
    renderObject
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<MainAxisAlignment>(
        'mainAxisAlignment', mainAxisAlignment));
    properties.add(EnumProperty<MainAxisSize>('mainAxisSize', mainAxisSize,
        defaultValue: MainAxisSize.max));
    properties.add(EnumProperty<CrossAxisAlignment>(
        'crossAxisAlignment', crossAxisAlignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>(
        'verticalDirection', verticalDirection,
        defaultValue: VerticalDirection.down));
    properties.add(EnumProperty<TextBaseline>('textBaseline', textBaseline,
        defaultValue: null));
  }
}

class AutoWidthColumFlex extends RenderFlex {
  AutoWidthColumFlex({
    List<RenderBox>? children,
    Axis direction = Axis.horizontal,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Clip clipBehavior = Clip.none,
  }) : super(
          children: children,
          direction: direction,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          clipBehavior: clipBehavior,
        );

  @override
  void performLayout() {
    super.performLayout();

    double maxWidth = 100;

    //遍历找出宽度的最大值
    RenderBox? child = firstChild;
    while (child != null) {
      final FlexParentData childParentData =
          child.parentData! as FlexParentData;
      if (child.hasSize && child.size.width > maxWidth) {
        maxWidth = child.size.width;
      }
      child = childParentData.nextSibling;
    }

    //给每个子组件设置该最大宽度
    child = firstChild;
    while (child != null) {
      final FlexParentData childParentData =
          child.parentData! as FlexParentData;
      child.layout(constraints.copyWith(minWidth: 100),
          parentUsesSize: true);
      child = childParentData.nextSibling;
    }
  }
}
