import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/services/supabase_service.dart';
import '../../data/models/user_model.dart';
import 'auth_controller.dart';

final onboardingControllerProvider = StateNotifierProvider<OnboardingController, int>((ref) {
  return OnboardingController(ref);
});

class OnboardingController extends StateNotifier<int> {
  final Ref _ref;
  final _client = SupabaseService.client;

  OnboardingController(this._ref) : super(0);

  String? college;
  int? year;
  List<String> courses = [];
  List<String> goals = [];
  String wakeTime = '08:00';

  void nextStep() => state++;
  void previousStep() => state--;

  Future<void> completeOnboarding() async {
    final user = _ref.read(authStateProvider).value?.session?.user;
    if (user == null) return;

    final updates = {
      'college': college,
      'year': year,
      'wake_time': wakeTime,
      'onboarded_at': DateTime.now().toIso8601String(),
    };

    await _client.from('users').update(updates).eq('id', user.id);
    
    // Add courses
    if (courses.isNotEmpty) {
      await _client.from('courses').insert(
        courses.map((name) => {'user_id': user.id, 'name': name}).toList()
      );
    }

    // Add goals
    if (goals.isNotEmpty) {
      await _client.from('goals').insert(
        goals.map((title) => {'user_id': user.id, 'title': title}).toList()
      );
    }

    _ref.invalidate(userProfileProvider);
  }
}
