import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/saved_item_model.dart';
import '../../data/repositories/saved_item_repository.dart';

final savedItemsProvider = StateNotifierProvider<CaptureController, AsyncValue<List<SavedItemModel>>>((ref) {
  final repository = ref.watch(savedItemRepositoryProvider);
  return CaptureController(repository);
});

class CaptureController extends StateNotifier<AsyncValue<List<SavedItemModel>>> {
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
      await _repository.createSavedItem(item);
      await loadItems();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _repository.deleteSavedItem(id);
      await loadItems();
    } catch (e) {
      // Handle error
    }
  }
}
