import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/briefing_model.dart';
import '../../data/repositories/briefing_repository.dart';

final briefingProvider = StateNotifierProvider<BriefingController, AsyncValue<BriefingModel?>>((ref) {
  final repository = ref.watch(briefingRepositoryProvider);
  return BriefingController(repository);
});

class BriefingController extends StateNotifier<AsyncValue<BriefingModel?>> {
  final BriefingRepository _repository;

  BriefingController(this._repository) : super(const AsyncValue.loading()) {
    loadBriefing();
  }

  Future<void> loadBriefing() async {
    state = const AsyncValue.loading();
    try {
      final briefing = await _repository.getLatestBriefing();
      state = AsyncValue.data(briefing);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> generateNewBriefing() async {
    state = const AsyncValue.loading();
    try {
      await _repository.generateBriefing();
      await loadBriefing();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> dismissBriefing(String id) async {
    try {
      await _repository.dismissBriefing(id);
      await loadBriefing();
    } catch (e) {
      // Log error but don't disrupt the view
    }
  }
}
