import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../controllers/settings_controller.dart';
import '../../../shared/widgets/app_bottom_sheet.dart';
import '../../../core/localization/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final settingsNotifier = ref.read(settingsControllerProvider.notifier);
    final loc = ref.watch(localizationsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(loc.translate('settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Genel Ayarlar
          Text(
            loc.translate('settings_general'),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSettingRow(
                  context,
                  icon: Icons.dark_mode_outlined,
                  title: loc.translate('theme'),
                  trailing: Switch(
                    value: settings.themeMode == ThemeMode.dark || (settings.themeMode == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark),
                    onChanged: (val) {
                      settingsNotifier.setThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                    },
                    activeColor: Theme.of(context).colorScheme.onPrimary,
                    activeTrackColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  context,
                  icon: Icons.currency_exchange,
                  title: loc.translate('currency'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        settings.currency == 'TL' ? 'TL (₺)' : 
                        settings.currency == 'USD' ? 'USD (\$)' : 'EUR (€)',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                            ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                    ],
                  ),
                  onTap: () {
                    AppBottomSheet.show(
                      context: context,
                      title: loc.translate('currency'),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('TL (₺)'),
                            trailing: settings.currency == 'TL' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                            onTap: () {
                              settingsNotifier.setCurrency('TL');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('USD (\$)'),
                            trailing: settings.currency == 'USD' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                            onTap: () {
                              settingsNotifier.setCurrency('USD');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('EUR (€)'),
                            trailing: settings.currency == 'EUR' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                            onTap: () {
                              settingsNotifier.setCurrency('EUR');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  context,
                  icon: Icons.language,
                  title: loc.translate('app_language'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        settings.language,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ],
                  ),
                  onTap: () {
                    AppBottomSheet.show(
                      context: context,
                      title: loc.translate('app_language'),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('Türkçe'),
                            trailing: settings.language == 'Türkçe' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                            onTap: () {
                              settingsNotifier.setLanguage('Türkçe');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('English'),
                            trailing: settings.language == 'English' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                            onTap: () {
                              settingsNotifier.setLanguage('English');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Veri & Güvenlik
          Text(
            loc.translate('settings_data_security'),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSettingRow(
                  context,
                  icon: Icons.cloud_off,
                  title: loc.translate('offline_mode'),
                  subtitle: loc.translate('offline_mode_desc'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  context,
                  icon: Icons.delete_outline,
                  title: loc.translate('clear_data'),
                  titleColor: Theme.of(context).colorScheme.error,
                  iconColor: Theme.of(context).colorScheme.error,
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: Text(loc.translate('clear_data')),
                        content: Text(loc.translate('clear_data_confirm')),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(loc.translate('cancel'))),
                          TextButton(
                            onPressed: () => Navigator.pop(c, true),
                            child: Text('Sil', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                          ),
                        ],
                      ),
                    );
                    
                    if (confirm == true) {
                      await settingsNotifier.clearAllData();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tüm veriler başarıyla silindi.')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Hakkında & İletişim
          Text(
            settings.language == 'English' ? 'ABOUT & CONTACT' : 'HAKKINDA & İLETİŞİM',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSettingRow(
                  context,
                  icon: Icons.language,
                  title: settings.language == 'English' ? 'Website' : 'Web Sitemiz',
                  subtitle: 'navessia.com',
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () async {
                    final url = Uri.parse('https://navessia.com');
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
                const Divider(height: 1),
                _buildSettingRow(
                  context,
                  icon: Icons.mail_outline,
                  title: settings.language == 'English' ? 'Contact Us' : 'Bize Ulaşın',
                  subtitle: 'navessia.com/contact',
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () async {
                    final url = Uri.parse('https://navessia.com/contact');
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.xl * 2),
          
          // App Version & Signature
          Center(
            child: Column(
              children: [
                Text(
                  '${loc.translate('app_name')} v1.0.0',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  settings.language == 'English' ? 'Made by Navessia' : 'Navessia tarafından geliştirildi',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.4),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildSettingRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? iconColor,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderLg,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: titleColor ?? Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
