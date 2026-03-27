import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gmailServiceProvider = Provider((ref) => GmailService());

class GmailService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<List<Message>> fetchRecruitmentEmails() async {
    final account = await _googleSignIn.attemptLightweightAuthentication();
    if (account == null) return [];

    final scopes = [GmailApi.gmailReadonlyScope];
    final authorization = await account.authorizationClient.authorizeScopes(scopes);
    final authClient = authorization.authClient(
      scopes: scopes,
    );

    final gmailApi = GmailApi(authClient);

    // Search for recruitment keywords
    final results = await gmailApi.users.messages.list(
      'me',
      q: 'subject:(interview OR recruitment OR application OR offer) OR from:(recruiter OR hr)',
      maxResults: 20,
    );

    if (results.messages == null) return [];

    final messages = <Message>[];
    for (var msg in results.messages!) {
      final fullMsg = await gmailApi.users.messages.get('me', msg.id!);
      messages.add(fullMsg);
    }

    return messages;
  }
}
