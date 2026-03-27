import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarServiceProvider = Provider((ref) => CalendarService());

class CalendarService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

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
      maxResults: 10,
      orderBy: 'startTime',
      singleEvents: true,
    );

    return events.items ?? [];
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
