import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initialize() async {
    // TODO: Replace with environment variables or user configuration
    const supabaseUrl = 'https://epudlrzohcgztuelyfmy.supabase.co';
    const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVwdWRscnpvaGNnenR1ZWx5Zm15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ1NTg5NDEsImV4cCI6MjA5MDEzNDk0MX0.SDJ_fmn0QfCjdXvBj5QaMYKG7YFi22GECJoLqgMdXFs';

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
