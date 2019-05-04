import 'dart:collection' show Queue;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

const double _kActiveFontSize = 12.0;
const double _kInactiveFontSize = 12.0;
const double _kTopMargin = 8.0;
const double _kBottomMargin = 8.0;
const double _kCustomBottomNavigationBarHeight = 0;

enum CustomBottomNavigationBarType {
  /// A bottom navigation bar like spotify's one
  /// The items are closer to the center
  /// The labels always have the same size and both, the icon and the color change there color when tapped
  spotifyLike,
}

class CustomBottomNavigationBar extends StatefulWidget {

  CustomBottomNavigationBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    CustomBottomNavigationBarType type,
    this.fixedColor,
    this.iconSize = 28.0, 
    this.bottomBarColor,
  }) : assert(items != null),
       assert(items.length >= 2),
       assert(
        items.every((BottomNavigationBarItem item) => item.title != null) == true,
        'Every item must have a non-null title',
       ),
       assert(0 <= currentIndex && currentIndex < items.length),
       assert(iconSize != null),
       type = type ?? CustomBottomNavigationBarType.spotifyLike,
       super(key: key);

  /// The interactive items laid out within the bottom navigation bar where each item has an icon and title.
  final List<BottomNavigationBarItem> items;

  // The background color of the bottom navigation bar
  final Color bottomBarColor;

  /// The callback that is called when a item is tapped.
  final ValueChanged<int> onTap;

  /// The index into [items] of the current active item.
  final int currentIndex;

  /// Defines the layout and behavior of a [CustomBottomNavigationBar].
  final CustomBottomNavigationBarType type;

  /// The color of the selected item when bottom navigation bar is
  final Color fixedColor;

  /// The size of all of the [BottomNavigationBarItem] icons.
  final double iconSize;

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

// This represents a single tile in the bottom navigation bar. It is intended
// to go into a flex container.
class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.type,
    this.item,
    this.animation,
    this.iconSize, {
    this.onTap,
    this.colorTween,
    this.flex,
    this.selected = false,
    this.indexLabel,
  }) : assert(selected != null);

  final CustomBottomNavigationBarType type;
  final BottomNavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback onTap;
  final ColorTween colorTween;
  final double flex;
  final bool selected;
  final String indexLabel;

  Widget _buildIcon() {
    double tweenStart;
    Color iconColor;
    switch (type) {
      /*case CustomBottomNavigationBarType.fixed:
        tweenStart = 8.0;
        iconColor = colorTween.evaluate(animation);
        break;
      case CustomBottomNavigationBarType.shifting:
        tweenStart = 16.0;
        iconColor = Colors.white;
        break;*/
      case CustomBottomNavigationBarType.spotifyLike:
        tweenStart = 8.0;
        iconColor = colorTween.evaluate(animation);
        break;
    }
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: Container(
        margin: EdgeInsets.only(
          top: Tween<double>(
            begin: tweenStart,
            end: _kTopMargin,
          ).evaluate(animation),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: iconSize,
          ),
          child: selected ? item.activeIcon : item.icon,
        ),
      ),
    );
  }

  Widget _buildFixedLabel() {
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: _kBottomMargin),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: _kActiveFontSize,
            color: colorTween.evaluate(animation),
          ),
          // The font size should grow here when active, but because of the way
          // font rendering works, it doesn't grow smoothly if we just animate
          // the font size, so we use a transform instead.
          child: Transform(
            transform: Matrix4.diagonal3(
              Vector3.all(
                Tween<double>(
                  begin: _kInactiveFontSize / _kActiveFontSize,
                  end: 1.0,
                ).evaluate(animation),
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: item.title,
          ),
        ),
      ),
    );
  }

  Widget _buildShiftingLabel() {
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(
        margin: EdgeInsets.only(
          bottom: Tween<double>(
            // In the spec, they just remove the label for inactive items and
            // specify a 16dp bottom margin. We don't want to actually remove
            // the label because we want to fade it in and out, so this modifies
            // the bottom margin to take that into account.
            begin: 2.0,
            end: _kBottomMargin,
          ).evaluate(animation),
        ),
        child: FadeTransition(
          alwaysIncludeSemantics: true,
          opacity: animation,
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              fontSize: _kActiveFontSize,
              color: Colors.white,
            ),
            child: item.title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // In order to use the flex container to grow the tile during animation, we
    // need to divide the changes in flex allotment into smaller pieces to
    // produce smooth animation. We do this by multiplying the flex value
    // (which is an integer) by a large number.
    int size;
    Widget label;
    switch (type) {
      /*case CustomBottomNavigationBarType.fixed:
        size = 1;
        label = _buildFixedLabel();
        break;
      case CustomBottomNavigationBarType.shifting:
        size = (flex * 1000.0).round();
        label = _buildShiftingLabel();
        break;*/
      case CustomBottomNavigationBarType.spotifyLike:
        size = 1;
        label = _buildFixedLabel();
        break;
    }
    return Expanded(
      flex: size,
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        child: Stack(
          children: <Widget>[
            InkResponse(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildIcon(),
                  label,
                ],
              ),
            ),
            Semantics(
              label: indexLabel,
            )
          ],
        ),
      ),
    );
  }
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations;

  // A queue of color splashes currently being animated.
  final Queue<_Circle> _circles = Queue<_Circle>();

  // Last splash circle's color, and the final color of the control after
  // animation is complete.
  Color _backgroundColor;

  static final Animatable<double> _flexTween = Tween<double>(begin: 1.0, end: 1.5);

  void _resetState() {
    for (AnimationController controller in _controllers)
      controller.dispose();
    for (_Circle circle in _circles)
      circle.dispose();
    _circles.clear();

    _controllers = List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations = List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {
      // Rebuilding when any of the controllers tick, i.e. when the items are
      // animated.
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers)
      controller.dispose();
    for (_Circle circle in _circles)
      circle.dispose();
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) => _flexTween.evaluate(animation);

  void _pushCircle(int index) {
    if (widget.items[index].backgroundColor != null) {
      _circles.add(
        _Circle(
          state: this,
          index: index,
          color: widget.items[index].backgroundColor,
          vsync: this,
        )..controller.addStatusListener(
          (AnimationStatus status) {
            switch (status) {
              case AnimationStatus.completed:
                setState(() {
                  final _Circle circle = _circles.removeFirst();
                  _backgroundColor = circle.color;
                  circle.dispose();
                });
                break;
              case AnimationStatus.dismissed:
              case AnimationStatus.forward:
              case AnimationStatus.reverse:
                break;
            }
          },
        ),
      );
    }
  }

  @override
  void didUpdateWidget(CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // No animated segue if the length of the items list changes.
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      switch (widget.type) {
        /*case CustomBottomNavigationBarType.fixed:
          break;
        case CustomBottomNavigationBarType.shifting:
          _pushCircle(widget.currentIndex);
          break;*/
        case CustomBottomNavigationBarType.spotifyLike:
          break;
      }
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor != widget.items[widget.currentIndex].backgroundColor)
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
    }
  }

  List<Widget> _createTiles() {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    assert(localizations != null);
    final List<Widget> children = <Widget>[];
    switch (widget.type) {
      /*case CustomBottomNavigationBarType.fixed:
        final ThemeData themeData = Theme.of(context);
        final TextTheme textTheme = themeData.textTheme;
        Color themeColor;
        switch (themeData.brightness) {
          case Brightness.light:
            themeColor = themeData.primaryColor;
            break;
          case Brightness.dark:
            themeColor = themeData.accentColor;
            break;
        }
        final ColorTween colorTween = ColorTween(
          begin: textTheme.caption.color,
          end: widget.fixedColor ?? themeColor,
        );
        for (int i = 0; i < widget.items.length; i += 1) {
          children.add(
            _BottomNavigationTile(
              widget.type,
              widget.items[i],
              _animations[i],
              widget.iconSize,
              onTap: () {
                if (widget.onTap != null)
                  widget.onTap(i);
              },
              colorTween: colorTween,
              selected: i == widget.currentIndex,
              indexLabel: localizations.tabLabel(tabIndex: i + 1, tabCount: widget.items.length),
            ),
          );
        }
        break;
      case CustomBottomNavigationBarType.shifting:
        for (int i = 0; i < widget.items.length; i += 1) {
          children.add(
            _BottomNavigationTile(
              widget.type,
              widget.items[i],
              _animations[i],
              widget.iconSize,
              onTap: () {
                if (widget.onTap != null)
                  widget.onTap(i);
              },
              flex: _evaluateFlex(_animations[i]),
              selected: i == widget.currentIndex,
              indexLabel: localizations.tabLabel(tabIndex: i + 1, tabCount: widget.items.length),
            ),
          );
        }
        break;*/
      case CustomBottomNavigationBarType.spotifyLike:
        final ThemeData themeData = Theme.of(context);
        final TextTheme textTheme = themeData.textTheme;
        Color themeColor;
        switch (themeData.brightness) {
          case Brightness.light:
            themeColor = themeData.primaryColor;
            break;
          case Brightness.dark:
            themeColor = themeData.accentColor;
            break;
        }
        final ColorTween colorTween = ColorTween(
          begin: textTheme.caption.color,
          end: widget.fixedColor ?? themeColor,
        );
        for (int i = 0; i < widget.items.length; i += 1) {
          children.add(
            _BottomNavigationTile(
              widget.type,
              widget.items[i],
              _animations[i],
              widget.iconSize,
              onTap: () {
                if (widget.onTap != null)
                  widget.onTap(i);
              },
              colorTween: colorTween,
              selected: i == widget.currentIndex,
              indexLabel: localizations.tabLabel(tabIndex: i + 1, tabCount: widget.items.length),
            ),
          );
        }
        break;
    }
    return children;
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));

    // Labels apply up to _bottomMargin padding. Remainder is media padding.
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - _kBottomMargin, 0.0);
    Color backgroundColor;
    switch (widget.type) {
      /*case CustomBottomNavigationBarType.fixed:
        break;
      case CustomBottomNavigationBarType.shifting:
        backgroundColor = _backgroundColor;
        break;*/
      case CustomBottomNavigationBarType.spotifyLike:
        //backgroundColor = _backgroundColor;
        backgroundColor = widget.bottomBarColor;
        break;
    }
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Material( // Casts shadow.
              elevation: 8.0,
              color: backgroundColor,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: _kCustomBottomNavigationBarHeight + additionalBottomPadding),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RadialPainter(
                      circles: _circles.toList(),
                      textDirection: Directionality.of(context),
                    ),
                  ),
                ),
                Material( // Splashes.
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: additionalBottomPadding, left: 48.0, right: 48.0),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: _createContainer(_createTiles()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Describes an animating color splash circle.
class _Circle {
  _Circle({
    @required this.state,
    @required this.index,
    @required this.color,
    @required TickerProvider vsync,
  }) : assert(state != null),
       assert(index != null),
       assert(color != null) {
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
  }

  final _CustomBottomNavigationBarState state;
  final int index;
  final Color color;
  AnimationController controller;
  CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      // We're adding flex values instead of animation values to produce correct
      // ratios.
      return animations.map<double>(state._evaluateFlex).fold<double>(0.0, (double sum, double value) => sum + value);
    }

    final double allWeights = weightSum(state._animations);
    // These weights sum to the start edge of the indexed item.
    final double leadingWeights = weightSum(state._animations.sublist(0, index));

    // Add half of its flex value in order to get to the center.
    return (leadingWeights + state._evaluateFlex(state._animations[index]) / 2.0) / allWeights;
  }

  void dispose() {
    controller.dispose();
  }
}

// Paints the animating color splash circles.
class _RadialPainter extends CustomPainter {
  _RadialPainter({
    @required this.circles,
    @required this.textDirection,
  }) : assert(circles != null),
       assert(textDirection != null);

  final List<_Circle> circles;
  final TextDirection textDirection;

  // Computes the maximum radius attainable such that at least one of the
  // bounding rectangle's corners touches the edge of the circle. Drawing a
  // circle larger than this radius is not needed, since there is no perceivable
  // difference within the cropped rectangle.
  static double _maxRadius(Offset center, Size size) {
    final double maxX = math.max(center.dx, size.width - center.dx);
    final double maxY = math.max(center.dy, size.height - center.dy);
    return math.sqrt(maxX * maxX + maxY * maxY);
  }

  @override
  bool shouldRepaint(_RadialPainter oldPainter) {
    if (textDirection != oldPainter.textDirection)
      return true;
    if (circles == oldPainter.circles)
      return false;
    if (circles.length != oldPainter.circles.length)
      return true;
    for (int i = 0; i < circles.length; i += 1)
      if (circles[i] != oldPainter.circles[i])
        return true;
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (_Circle circle in circles) {
      final Paint paint = Paint()..color = circle.color;
      final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
      canvas.clipRect(rect);
      double leftFraction;
      switch (textDirection) {
        case TextDirection.rtl:
          leftFraction = 1.0 - circle.horizontalLeadingOffset;
          break;
        case TextDirection.ltr:
          leftFraction = circle.horizontalLeadingOffset;
          break;
      }
      final Offset center = Offset(leftFraction * size.width, size.height / 2.0);
      final Tween<double> radiusTween = Tween<double>(
        begin: 0.0,
        end: _maxRadius(center, size),
      );
      canvas.drawCircle(
        center,
        radiusTween.transform(circle.animation.value),
        paint,
      );
    }
  }
}