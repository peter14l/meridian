import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_item_model.dart';
import '../services/supabase_service.dart';

final savedItemRepositoryProvider = Provider((ref) => SavedItemRepository());

class SavedItemRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<SavedItemModel>> getSavedItems() async {
    final response = await _client
        .from('saved_items')
        .select()
        .filter('deleted_at', 'is', null)
        .order('created_at', ascending: false);

    return (response as List).map((json) => SavedItemModel.fromJson(json)).toList();
  }

  Future<SavedItemModel> createSavedItem(SavedItemModel item) async {
    final response = await _client
        .from('saved_items')
        .insert(item.toJson())
        .select()
        .single();
    return SavedItemModel.fromJson(response);
  }

  Future<void> deleteSavedItem(String id) async {
    await _client
        .from('saved_items')
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', id);
  }
}
