import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/task_repository.dart';
import '../models/task_model.dart';
import 'package:uuid/uuid.dart';

final calendarServiceProvider = Provider((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return CalendarService(taskRepository);
});

class CalendarService {
  final TaskRepository _taskRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  CalendarService(this._taskRepository);

  Future<GoogleSignInAccount?> signIn() async {
    return await _googleSignIn.authenticate();
  }

  Future<List<Event>> getUpcomingEvents() async {
    final account = await _googleSignIn.attemptLightweightAuthentication();
    if (account == null) return [];

    final scopes = [CalendarApi.calendarReadonlyScope];
    final authorization = await account.authorizationClient.authorizeScopes(scopes);
    final authClient = authorization.authClient(
      scopes: scopes,
    );
    
    final calendarApi = CalendarApi(authClient);

    final events = await calendarApi.events.list(
      'primary',
      timeMin: DateTime.now().toUtc(),
      maxResults: 20,
      orderBy: 'startTime',
      singleEvents: true,
    );

    return events.items ?? [];
  }

  Future<void> syncEventsToTasks(String userId) async {
    final events = await getUpcomingEvents();
    final keywords = ['assignment', 'submit', 'exam', 'quiz', 'deadline', 'test'];
    
    for (final event in events) {
      final summary = event.summary?.toLowerCase() ?? '';
      if (keywords.any((k) => summary.contains(k))) {
        // Auto-import as task
        final newTask = TaskModel(
          id: const Uuid().v4(),
          userId: userId,
          title: event.summary ?? 'Untitled Event',
          description: event.description,
          dueAt: event.start?.dateTime ?? event.start?.date,
          priority: 1, // Default high priority for deadlines
        );
        await _taskRepository.createTask(newTask);
      }
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
