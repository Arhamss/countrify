import 'dart:async';

import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/shared/countrify_check_icon.dart';
import 'package:flutter/material.dart';

/// Generic dropdown overlay for searchable geo fields (state / city).
///
/// Anchored below (or above) the triggering text field via a [LayerLink].
/// Loads items asynchronously, filters on query changes, and calls
/// [onSelected] when a row is tapped.
class GeoSearchOverlay<T> extends StatefulWidget {
  const GeoSearchOverlay({
    required this.link,
    required this.fieldKey,
    required this.fieldWidth,
    required this.items,
    required this.query,
    required this.nameOf,
    required this.onSelected,
    required this.onDismiss,
    super.key,
    this.selected,
    this.subtitleOf,
    this.theme,
    this.maxHeight = 240,
  });

  final LayerLink link;
  final GlobalKey fieldKey;
  final double fieldWidth;
  final List<T> items;
  final String query;
  final String Function(T) nameOf;
  final String Function(T)? subtitleOf;
  final T? selected;
  final ValueChanged<T> onSelected;
  final VoidCallback onDismiss;
  final GeoPickerTheme? theme;
  final double maxHeight;

  @override
  State<GeoSearchOverlay<T>> createState() => _GeoSearchOverlayState<T>();
}

class _GeoSearchOverlayState<T> extends State<GeoSearchOverlay<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fade;
  bool _closing = false;

  static const double _gap = 4;
  static const double _minSpaceBelow = 120;
  static const double _edgeMargin = 20;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      reverseDuration: const Duration(milliseconds: 140),
    );
    _fade = CurvedAnimation(
        parent: _animController, curve: Curves.easeOutCubic);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _runExitThen(VoidCallback after) async {
    if (_closing) return;
    _closing = true;
    if (mounted) await _animController.reverse();
    after();
  }

  ({bool openAbove, double maxHeight}) _resolvePlacement() {
    final mq = MediaQuery.of(context);
    final screenH = mq.size.height;
    final kbInset = mq.viewInsets.bottom;
    final topPad = mq.padding.top;

    final box =
        widget.fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      return (openAbove: false, maxHeight: widget.maxHeight);
    }

    final fieldTop = box.localToGlobal(Offset.zero).dy;
    final fieldBottom = fieldTop + box.size.height;
    final below = screenH - fieldBottom - kbInset - _gap;
    final above = fieldTop - topPad - _gap;
    final openAbove = below < _minSpaceBelow && above > below;
    final available = openAbove ? above : below;
    return (
      openAbove: openAbove,
      maxHeight: (available - _edgeMargin).clamp(0.0, widget.maxHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placement = _resolvePlacement();
    final openAbove = placement.openAbove;
    final effectiveMax =
        placement.maxHeight > 0 ? placement.maxHeight : widget.maxHeight;
    final theme = widget.theme;

    final targetAnchor =
        openAbove ? Alignment.topLeft : Alignment.bottomLeft;
    final followerAnchor =
        openAbove ? Alignment.bottomLeft : Alignment.topLeft;
    final offset =
        openAbove ? const Offset(0, -_gap) : const Offset(0, _gap);

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => _runExitThen(widget.onDismiss),
            behavior: HitTestBehavior.translucent,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: widget.link,
          showWhenUnlinked: false,
          offset: offset,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          child: FadeTransition(
            opacity: _fade,
            child: Material(
              elevation: 6,
              shadowColor: Colors.black26,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: theme?.backgroundColor ?? Colors.white,
              child: Container(
                width: widget.fieldWidth,
                constraints: BoxConstraints(maxHeight: effectiveMax),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: theme?.borderColor ?? Colors.grey.shade300,
                  ),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                  child: _buildList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    final items = widget.items;
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Text(
          'No results',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        final isSelected = widget.selected != null && item == widget.selected;
        final name = widget.nameOf(item);
        final subtitle = widget.subtitleOf?.call(item);

        return InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            _runExitThen(() => widget.onSelected(item));
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: isSelected
                ? (widget.theme?.itemSelectedColor ??
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.08))
                : null,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  CountrifyCheckIcon(
                    size: 16,
                    color: widget.theme?.itemSelectedIconColor ??
                        Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
