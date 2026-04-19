import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/services/supabase_service.dart';
import 'auth_controller.dart';

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, int>((ref) {
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
    try {
      final user = _ref.read(authStateProvider).value?.session?.user;
      if (user == null) {
        // No user session, redirect to auth
        return;
      }

      // Ensure user record exists (handles edge cases like OAuth sign-in timing)
      final existingUser = await _client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      if (existingUser == null) {
        await _client.from('users').insert({
          'id': user.id,
          'email': user.email,
        });
      }

      final updates = {
        'college': college,
        'year': year,
        'wake_time': wakeTime,
        'onboarded_at': DateTime.now().toIso8601String(),
      };

      await _client.from('users').update(updates).eq('id', user.id);

      // Add courses
      if (courses.isNotEmpty) {
        await _client
            .from('courses')
            .insert(
              courses
                  .map((name) => {'user_id': user.id, 'name': name})
                  .toList(),
            );
      }

      // Add goals
      if (goals.isNotEmpty) {
        await _client
            .from('goals')
            .insert(
              goals
                  .map((title) => {'user_id': user.id, 'title': title})
                  .toList(),
            );
      }

      _ref.invalidate(userProfileProvider);
    } catch (e) {
      // Log error but don't crash - onboarding data can be saved later
      print('Onboarding error: $e');
    }
  }
}
