import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cqaaq_app/index.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final int currBarItem;
  final Duration animationDuration;
  final double elevation;
  final ValueChanged<int> onItemTap;
  final Color? backgroundColor;

  const AnimatedBottomBar({
    super.key,
    required this.barItems,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.elevation,
    required this.onItemTap,
    required this.currBarItem,
    this.backgroundColor,
  });

  @override
  State<AnimatedBottomBar> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor ?? Theme.of(context).colorScheme.background,
      elevation: widget.elevation,
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AnimatedBarItem(
                currBarItem: widget.currBarItem,
                isSelected: widget.currBarItem == 0,
                animationDuration: widget.animationDuration,
                barItem: widget.barItems[0],
                elevation: widget.elevation,
                onItemTap: widget.onItemTap,
                thisItemIndex: 0,
              ),
              AnimatedBarItem(
                currBarItem: widget.currBarItem,
                isSelected: widget.currBarItem == 1,
                animationDuration: widget.animationDuration,
                barItem: widget.barItems[1],
                elevation: widget.elevation,
                onItemTap: widget.onItemTap,
                thisItemIndex: 1,
              ),
              AnimatedBarItem(
                currBarItem: widget.currBarItem,
                isSelected: widget.currBarItem == 2,
                animationDuration: widget.animationDuration,
                barItem: widget.barItems[2],
                elevation: widget.elevation,
                onItemTap: widget.onItemTap,
                thisItemIndex: 2,
              ),
              AnimatedBarItem(
                currBarItem: widget.currBarItem,
                isSelected: widget.currBarItem == 3,
                animationDuration: widget.animationDuration,
                barItem: widget.barItems[3],
                elevation: widget.elevation,
                onItemTap: widget.onItemTap,
                thisItemIndex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBarItem extends StatefulWidget {
  final bool isSelected;
  final int currBarItem;
  final BarItem barItem;
  final int thisItemIndex;
  final Duration animationDuration;
  final double elevation;
  final ValueChanged<int> onItemTap;

  const AnimatedBarItem({
    super.key,
    required this.isSelected,
    required this.thisItemIndex,
    required this.barItem,
    required this.currBarItem,
    required this.animationDuration,
    required this.elevation,
    required this.onItemTap,
  });
  @override
  State<AnimatedBarItem> createState() => _AnimatedBarItemState();
}

class _AnimatedBarItemState extends State<AnimatedBarItem> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onItemTap(widget.thisItemIndex),
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        padding: widget.isSelected
            ? const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8.0,
              )
            : const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
        duration: widget.animationDuration,
        decoration: BoxDecoration(
          color: widget.isSelected ? widget.barItem.color!.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              widget.barItem.icon,
              color: widget.isSelected ? widget.barItem.color : Theme.of(context).colorScheme.onBackground,
              size: widget.barItem.iconSize,
            ),
            const Gap(5.0),
            AnimatedSize(
              curve: Curves.easeInOut,
              duration: widget.animationDuration,
              child: LimitedBox(
                maxWidth: 70.0,
                child: AutoSizeText(
                  widget.isSelected ? "${widget.barItem.text}" : "",
                  style: GoogleFonts.montserrat(
                    color: widget.barItem.color,
                    fontWeight: FontWeight.w600,
                    fontSize: widget.barItem.textSize,
                  ),
                  maxFontSize: widget.barItem.textSize!,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
