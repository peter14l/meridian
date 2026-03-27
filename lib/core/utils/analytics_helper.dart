import 'package:posthog_flutter/posthog_flutter.dart';

class AnalyticsHelper {
  static final Posthog _posthog = Posthog();

  static Future<void> logEvent(String name, {Map<String, dynamic>? properties}) async {
    await _posthog.capture(
      eventName: name,
      properties: properties?.cast<String, Object>(),
    );
  }

  static Future<void> identify(String userId, {Map<String, dynamic>? userProperties}) async {
    await _posthog.identify(
      userId: userId,
      userProperties: userProperties?.cast<String, Object>(),
    );
  }

  static Future<void> screen(String name) async {
    await _posthog.screen(screenName: name);
  }
}
