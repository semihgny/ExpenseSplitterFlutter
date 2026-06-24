import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';

import '../../../shared/widgets/app_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../controllers/group_controller.dart';

class CreateGroupSheet extends ConsumerStatefulWidget {
  const CreateGroupSheet({super.key});

  @override
  ConsumerState<CreateGroupSheet> createState() => _CreateGroupSheetState();
}

class _CreateGroupSheetState extends ConsumerState<CreateGroupSheet> {
  final _nameController = TextEditingController();
  String _selectedCategory = '';
  
  final List<String> _categories = ['category_home', 'category_holiday', 'category_camp', 'category_office'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = ref.watch(localizationsProvider);
    
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppInput(
            controller: _nameController,
            label: loc.translate('group_name').toUpperCase(),
            hintText: loc.translate('group_name_hint'),
            autofocus: true,
          ),
          const SizedBox(height: AppSpacing.lg),
          
          Text(
            loc.translate('suggestions'),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              return FilterChip(
                label: Text(loc.translate(category)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? category : '';
                    if (selected) {
                      _nameController.text = loc.translate(category);
                    }
                  });
                },
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                selectedColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
                checkmarkColor: Theme.of(context).colorScheme.primaryContainer,
                labelStyle: TextStyle(
                  color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.borderSm,
                  side: BorderSide(
                    color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          PrimaryButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              if (name.isEmpty) return;
              
              final controller = ref.read(groupControllerProvider.notifier);
              await controller.createGroup(
                name: name,
                category: _selectedCategory.isEmpty ? null : _selectedCategory,
              );
              
              if (!context.mounted) return;
              
              final state = ref.read(groupControllerProvider);
              if (state.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hata: ${state.error}')),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(loc.translate('create')),
          ),
          
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
