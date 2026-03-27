import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/services/supabase_service.dart';
import '../../data/models/user_model.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return SupabaseService.client.auth.onAuthStateChange;
});

final userProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.value?.session?.user;
  if (user == null) return null;

  final response = await SupabaseService.client
      .from('users')
      .select()
      .eq('id', user.id)
      .maybeSingle();

  if (response == null) return null;
  return UserModel.fromJson(response);
});

final authControllerProvider = Provider((ref) => AuthController());

class AuthController {
  final SupabaseClient _client = SupabaseService.client;

  Future<void> signInWithEmail(String email, String password) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUpWithEmail(String email, String password) async {
    await _client.auth.signUp(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.meridian://login-callback/',
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
