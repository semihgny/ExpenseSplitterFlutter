import 'package:flutter/material.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/app_localizations.dart';

/// Custom bottom navigation bar for the main app shell.
///
/// 4 tabs: Kişisel, Paylaşımlı, Kayıtlar, Ayarlar.
/// Active items use [Theme.of(context).colorScheme.primaryContainer] with a filled icon variant.
/// Inactive items use [Theme.of(context).colorScheme.secondary] with an outlined icon.
class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const double _height = 64;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(localizationsProvider);
    
    final tabs = [
      _NavTab(icon: Icons.person_outlined, activeIcon: Icons.person, label: loc.translate('tab_personal')),
      _NavTab(icon: Icons.history_outlined, activeIcon: Icons.history, label: loc.translate('tab_history')),
      _NavTab(icon: Icons.settings_outlined, activeIcon: Icons.settings, label: loc.translate('tab_settings')),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000), // rgba(0,0,0,0.05)
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _height,
          child: Row(
            children: List.generate(
              tabs.length,
              (index) => Expanded(
                child: _NavItem(
                  icon: tabs[index].icon,
                  activeIcon: tabs[index].activeIcon,
                  label: tabs[index].label,
                  isActive: currentIndex == index,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Descriptor for a single navigation tab.
class _NavTab {
  const _NavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// A single item inside the bottom navigation bar.
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.secondary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
