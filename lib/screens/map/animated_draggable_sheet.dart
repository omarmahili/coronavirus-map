import 'package:coronavirusapp/screens/map/countries_list.dart';
import 'package:flutter/material.dart';

class AnimatedDraggableSheet extends StatefulWidget {
  final double minHeight;
  final double maxHeight;

  AnimatedDraggableSheet({
    @required this.minHeight,
    @required this.maxHeight,
  });

  @override
  AnimatedDraggableSheetState createState() => AnimatedDraggableSheetState();
}

class AnimatedDraggableSheetState extends State<AnimatedDraggableSheet>
    with SingleTickerProviderStateMixin {
  AnimationController initialBottomCardAnimationController;
  Animation initialBottomCardAnimation;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    initialBottomCardAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    initialBottomCardAnimation = Tween(begin: 0.0, end: widget.minHeight)
        .animate(initialBottomCardAnimationController);

    startAnimation();
  }

  startAnimation() {
    initialBottomCardAnimationController.forward().whenCompleteOrCancel(() {
      setState(() {
        isAnimationCompleted = true;
      });
    });
  }

  Widget buildContent({controller, closeSheet}) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        child: ConnectedCountriesList(
          controller: controller,
          closeSheet: closeSheet,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (!isAnimationCompleted) {
      return AnimatedBuilder(
        animation: initialBottomCardAnimation,
        child: SizedBox.shrink(),
        builder: (context, child) {
          return Positioned(
            top: height - initialBottomCardAnimation.value,
            left: 0,
            right: 0,
            child: child,
          );
        },
      );
    }

    return SizedBox(
      child: DraggableScrollableActuator(
        child: DraggableScrollableSheet(
          maxChildSize: widget.maxHeight / height,
          initialChildSize: widget.minHeight / height,
          minChildSize: widget.minHeight / height,
          builder: (context, scrollController) => buildContent(
            controller: scrollController,
            closeSheet: () => DraggableScrollableActuator.reset(context),
          ),
        ),
      ),
    );
  }
}
