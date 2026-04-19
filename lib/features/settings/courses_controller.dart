import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/services/supabase_service.dart';

final coursesProvider =
    StateNotifierProvider<CoursesController, AsyncValue<List<CourseModel>>>((
      ref,
    ) {
      return CoursesController();
    });

class CoursesController extends StateNotifier<AsyncValue<List<CourseModel>>> {
  final SupabaseClient _client = SupabaseService.client;

  CoursesController() : super(const AsyncValue.loading()) {
    loadCourses();
  }

  Future<void> loadCourses() async {
    state = const AsyncValue.loading();
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        state = const AsyncValue.data([]);
        return;
      }
      final response = await _client
          .from('courses')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);
      final courses = (response as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();
      state = AsyncValue.data(courses);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addCourse(String name, {String? code, String? color}) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return;

      await _client.from('courses').insert({
        'user_id': user.id,
        'name': name,
        'code': code,
        'color': color,
      });
      await loadCourses();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateCourse(
    String id, {
    String? name,
    String? code,
    String? color,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (code != null) updates['code'] = code;
      if (color != null) updates['color'] = color;
      updates['updated_at'] = DateTime.now().toIso8601String();

      await _client.from('courses').update(updates).eq('id', id);
      await loadCourses();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      await _client.from('courses').delete().eq('id', id);
      await loadCourses();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

class CourseModel {
  final String id;
  final String userId;
  final String name;
  final String? code;
  final String? color;
  final int? credits;
  final String? semester;
  final DateTime? createdAt;

  CourseModel({
    required this.id,
    required this.userId,
    required this.name,
    this.code,
    this.color,
    this.credits,
    this.semester,
    this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      color: json['color'] as String?,
      credits: json['credits'] as int?,
      semester: json['semester'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'code': code,
      'color': color,
      'credits': credits,
      'semester': semester,
    };
  }
}
