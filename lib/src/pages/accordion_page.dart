import 'package:flutter/material.dart';

import '../widgets/hs_accordion.dart';

class AccordionPage extends StatelessWidget {
  const AccordionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('手风琴组件')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '常见问题',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          HsAccordion(
            initialExpandedIndex: 0,
            items: [
              HsAccordionItem(
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFE8F1FF),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 18,
                    color: Color(0xFF2563EB),
                  ),
                ),
                title: Text(
                  '组件支持哪些场景？',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '适合 FAQ、设置页分组、商品详情说明等内容折叠展示。',
                  style: TextStyle(fontSize: 13, color: Color(0xFF667085)),
                ),
                content: Text(
                  'HsAccordion 默认是单开模式，点击新的面板会自动收起旧面板。'
                  '如果只需要基础折叠展示，直接传入标题和内容即可。',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Color(0xFF344054),
                  ),
                ),
              ),
              HsAccordionItem(
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFFFF1E8),
                  child: Icon(
                    Icons.palette_outlined,
                    size: 18,
                    color: Color(0xFFF97316),
                  ),
                ),
                title: Text(
                  '能自定义样式吗？',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '支持统一配置和单项覆盖：',
                      style: TextStyle(fontSize: 14, color: Color(0xFF344054)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• 背景色 / 展开色\n'
                      '• 圆角 / 边框\n'
                      '• 标题区和内容区内边距',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF344054),
                      ),
                    ),
                  ],
                ),
              ),
              HsAccordionItem(
                enabled: false,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFF2F4F7),
                  child: Icon(
                    Icons.lock_outline,
                    size: 18,
                    color: Color(0xFF98A2B3),
                  ),
                ),
                title: Text(
                  '禁用项示例',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF98A2B3),
                  ),
                ),
                subtitle: Text(
                  '禁用后不会响应点击。',
                  style: TextStyle(fontSize: 13, color: Color(0xFF98A2B3)),
                ),
                content: Text('这段内容不会被展开。'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
