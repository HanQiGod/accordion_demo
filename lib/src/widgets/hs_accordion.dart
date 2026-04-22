import 'package:flutter/material.dart';

/// 手风琴单项配置
class HsAccordionItem {
  const HsAccordionItem({
    required this.title,
    required this.content,
    this.subtitle,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.border,
    this.borderRadius,
    this.headerPadding,
    this.contentPadding,
  });

  /// 标题
  final Widget title;

  /// 展开内容
  final Widget content;

  /// 标题下方的副标题
  final Widget? subtitle;

  /// 标题左侧组件
  final Widget? leading;

  /// 标题右侧组件，未传时使用默认箭头
  final Widget? trailing;

  /// 是否允许点击展开
  final bool enabled;

  /// 收起时背景色
  final Color? backgroundColor;

  /// 展开时背景色
  final Color? expandedBackgroundColor;

  /// 单项边框
  final BoxBorder? border;

  /// 单项圆角
  final BorderRadius? borderRadius;

  /// 标题区域内边距
  final EdgeInsetsGeometry? headerPadding;

  /// 内容区域内边距
  final EdgeInsetsGeometry? contentPadding;
}

/// 手风琴样式组件
///
/// 默认同一时间只展开一个面板，再次点击当前面板时会收起。
/// 默认单开模式，支持初始展开项、展开变化回调、禁用态、标题/副标题/前后缀、自定义内边距、边框、圆角、背景色，以及展开收起动画。
class HsAccordion extends StatefulWidget {
  const HsAccordion({
    super.key,
    required this.items,
    this.initialExpandedIndex,
    this.onChanged,
    this.itemSpacing = 12,
    this.headerPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    this.backgroundColor = Colors.white,
    this.expandedBackgroundColor = const Color(0xFFF8FAFC),
    this.border = const Border.fromBorderSide(
      BorderSide(color: Color(0xFFE5E7EB)),
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.iconColor = const Color(0xFF667085),
    this.disabledColor = const Color(0xFF98A2B3),
    this.animationDuration = const Duration(milliseconds: 240),
    this.animationCurve = Curves.easeOutCubic,
    this.clipBehavior = Clip.antiAlias,
  })  : assert(
          initialExpandedIndex == null ||
              (initialExpandedIndex >= 0 &&
                  initialExpandedIndex < items.length),
          'initialExpandedIndex 超出 items 范围',
        ),
        assert(itemSpacing >= 0, 'itemSpacing must be >= 0');

  /// 面板列表
  final List<HsAccordionItem> items;

  /// 默认展开项下标
  final int? initialExpandedIndex;

  /// 当前展开项变化回调，全部收起时回调 `null`
  final ValueChanged<int?>? onChanged;

  /// 面板之间的间距
  final double itemSpacing;

  /// 默认标题区域内边距
  final EdgeInsetsGeometry headerPadding;

  /// 默认内容区域内边距
  final EdgeInsetsGeometry contentPadding;

  /// 默认收起背景色
  final Color backgroundColor;

  /// 默认展开背景色
  final Color expandedBackgroundColor;

  /// 默认边框
  final BoxBorder? border;

  /// 默认圆角
  final BorderRadius borderRadius;

  /// 默认箭头颜色
  final Color iconColor;

  /// 禁用态颜色
  final Color disabledColor;

  /// 动画时长
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  /// 裁剪行为
  final Clip clipBehavior;

  @override
  State<HsAccordion> createState() => _HsAccordionState();
}

class _HsAccordionState extends State<HsAccordion> {
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _expandedIndex = widget.initialExpandedIndex;
  }

  @override
  void didUpdateWidget(covariant HsAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialExpandedIndex != oldWidget.initialExpandedIndex) {
      _expandedIndex = widget.initialExpandedIndex;
      return;
    }

    if (_expandedIndex != null && _expandedIndex! >= widget.items.length) {
      _expandedIndex = null;
    }
  }

  void _toggleItem(int index) {
    final HsAccordionItem item = widget.items[index];
    if (!item.enabled) return;

    final int? nextExpandedIndex = _expandedIndex == index ? null : index;
    setState(() {
      _expandedIndex = nextExpandedIndex;
    });
    widget.onChanged?.call(nextExpandedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List<Widget>.generate(widget.items.length, (int index) {
        final HsAccordionItem item = widget.items[index];
        final bool isExpanded = _expandedIndex == index;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == widget.items.length - 1 ? 0 : widget.itemSpacing,
          ),
          child: _AccordionPanel(
            index: index,
            item: item,
            isExpanded: isExpanded,
            animationDuration: widget.animationDuration,
            animationCurve: widget.animationCurve,
            headerPadding: item.headerPadding ?? widget.headerPadding,
            contentPadding: item.contentPadding ?? widget.contentPadding,
            backgroundColor: item.backgroundColor ?? widget.backgroundColor,
            expandedBackgroundColor:
                item.expandedBackgroundColor ?? widget.expandedBackgroundColor,
            border: item.border ?? widget.border,
            borderRadius: item.borderRadius ?? widget.borderRadius,
            iconColor: widget.iconColor,
            disabledColor: widget.disabledColor,
            clipBehavior: widget.clipBehavior,
            onTap: () => _toggleItem(index),
          ),
        );
      }),
    );
  }
}

class _AccordionPanel extends StatelessWidget {
  const _AccordionPanel({
    required this.index,
    required this.item,
    required this.isExpanded,
    required this.animationDuration,
    required this.animationCurve,
    required this.headerPadding,
    required this.contentPadding,
    required this.backgroundColor,
    required this.expandedBackgroundColor,
    required this.border,
    required this.borderRadius,
    required this.iconColor,
    required this.disabledColor,
    required this.clipBehavior,
    required this.onTap,
  });

  final int index;
  final HsAccordionItem item;
  final bool isExpanded;
  final Duration animationDuration;
  final Curve animationCurve;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry contentPadding;
  final Color backgroundColor;
  final Color expandedBackgroundColor;
  final BoxBorder? border;
  final BorderRadius borderRadius;
  final Color iconColor;
  final Color disabledColor;
  final Clip clipBehavior;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color effectiveIconColor = item.enabled ? iconColor : disabledColor;

    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      decoration: BoxDecoration(
        color: isExpanded ? expandedBackgroundColor : backgroundColor,
        border: border,
        borderRadius: borderRadius,
      ),
      clipBehavior: clipBehavior,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              key: ValueKey('hs-accordion-header-$index'),
              onTap: item.enabled ? onTap : null,
              child: Padding(
                padding: headerPadding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.leading != null) ...[
                      item.leading!,
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          item.title,
                          if (item.subtitle != null) ...[
                            const SizedBox(height: 4),
                            item.subtitle!,
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    item.trailing ??
                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: animationDuration,
                          curve: animationCurve,
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: effectiveIconColor,
                          ),
                        ),
                  ],
                ),
              ),
            ),
            ClipRect(
              child: AnimatedSize(
                duration: animationDuration,
                curve: animationCurve,
                alignment: Alignment.topCenter,
                child: isExpanded
                    ? Padding(
                        padding: contentPadding,
                        child: item.content,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
