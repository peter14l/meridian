import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'capture_controller.dart';
import '../../data/models/saved_item_model.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/meridian_button.dart';
import '../auth/auth_controller.dart';

class CaptureScreen extends ConsumerWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(savedItemsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Smart Capture',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return _EmptyCaptureView();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _SavedItemCard(item: item);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => _showAddCaptureSheet(context, ref),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: const Icon(Icons.add_link_rounded, size: 32),
      ),
    );
  }

  void _showAddCaptureSheet(BuildContext context, WidgetRef ref) {
    final urlController = TextEditingController();
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.session?.user.id;

    if (userId == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            left: 24,
            right: 24,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Capture Link', 
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'AI will automatically tag and summarize it.',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: urlController,
                autofocus: true,
                style: theme.textTheme.titleMedium,
                decoration: InputDecoration(
                  labelText: 'URL',
                  hintText: 'https://...',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainer,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.link_rounded),
                ),
              ),
              const SizedBox(height: 32),
              MeridianButton(
                label: 'Save Link',
                onPressed: () {
                  final url = urlController.text.trim();
                  if (url.isNotEmpty) {
                    final newItem = SavedItemModel(
                      id: const Uuid().v4(),
                      userId: userId,
                      url: url,
                    );
                    ref.read(savedItemsProvider.notifier).createItem(newItem);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyCaptureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your Smart Library is empty',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Save links from your browser or shared from other apps. AI will do the rest.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedItemCard extends StatelessWidget {
  final SavedItemModel item;

  const _SavedItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAI = item.aiSummary != null || (item.aiTags != null && item.aiTags!.isNotEmpty);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlowCard(
        isAI: hasAI,
        color: hasAI ? null : theme.colorScheme.surfaceContainerLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _getTagColor(context, item.tag).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTagIcon(item.tag),
                    size: 20,
                    color: _getTagColor(context, item.tag),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title ?? item.url,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            if (item.aiSummary != null) ...[
              const SizedBox(height: 12),
              Text(
                item.aiSummary!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
            if (item.aiTags != null && item.aiTags!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.aiTags!.map((tag) => _AITagChip(label: tag)).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getTagIcon(SavedTag? tag) {
    switch (tag) {
      case SavedTag.article: return Icons.article_rounded;
      case SavedTag.job: return Icons.work_rounded;
      case SavedTag.resource: return Icons.menu_book_rounded;
      case SavedTag.tool: return Icons.build_rounded;
      case SavedTag.research: return Icons.science_rounded;
      default: return Icons.link_rounded;
    }
  }

  Color _getTagColor(BuildContext context, SavedTag? tag) {
    final theme = Theme.of(context);
    switch (tag) {
      case SavedTag.article: return Colors.orange;
      case SavedTag.job: return theme.colorScheme.primary;
      case SavedTag.resource: return Colors.teal;
      case SavedTag.tool: return Colors.indigo;
      case SavedTag.research: return theme.colorScheme.tertiary;
      default: return theme.colorScheme.onSurfaceVariant;
    }
  }
}

class _AITagChip extends StatelessWidget {
  final String label;

  const _AITagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.tertiary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, size: 12, color: theme.colorScheme.tertiary),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.tertiary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
