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

    // Ensure user record exists (handles edge cases)
    final user = _client.auth.currentUser;
    if (user != null) {
      final existingUser = await _client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      if (existingUser == null) {
        await _client.from('users').insert({'id': user.id, 'email': email});
      }
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    await _client.auth.signUp(email: email, password: password);

    // Get the newly created user and create a profile record
    final user = _client.auth.currentUser;
    if (user != null) {
      await _client.from('users').insert({'id': user.id, 'email': email});
    }
  }

  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.meridian://login-callback/',
    );

    // Create user record if not exists (needed after OAuth sign-in)
    final user = _client.auth.currentUser;
    if (user != null) {
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
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
