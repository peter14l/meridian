import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/saved_item_model.dart';
import '../../data/repositories/saved_item_repository.dart';
import '../../data/services/supabase_service.dart';

final savedItemsProvider =
    StateNotifierProvider<CaptureController, AsyncValue<List<SavedItemModel>>>((
      ref,
    ) {
      final repository = ref.watch(savedItemRepositoryProvider);
      return CaptureController(repository);
    });

class CaptureController
    extends StateNotifier<AsyncValue<List<SavedItemModel>>> {
  final SavedItemRepository _repository;

  CaptureController(this._repository) : super(const AsyncValue.loading()) {
    loadItems();
  }

  Future<void> loadItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.getSavedItems();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createItem(SavedItemModel item) async {
    try {
      // First save the item to the database
      final createdItem = await _repository.createSavedItem(item);

      // Then trigger AI tagging (fire and forget - it will update the item)
      _triggerAITagging(createdItem.id);

      // Reload items to show the new item
      await loadItems();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> _triggerAITagging(String itemId) async {
    try {
      final client = SupabaseService.client;
      // Call the tag-saved-item edge function
      await client.functions.invoke('tag-saved-item', body: {'id': itemId});
    } on Exception {
      // Silently fail - AI tagging is a nice-to-have enhancement
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _repository.deleteSavedItem(id);
      await loadItems();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
