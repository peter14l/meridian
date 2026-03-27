import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';

enum TimerStatus { idle, running, paused, completed }

final studyTimerProvider = StateNotifierProvider<StudyTimerController, TimerState>((ref) {
  return StudyTimerController();
});

class TimerState {
  final int secondsRemaining;
  final TimerStatus status;
  final int totalSeconds;

  TimerState({
    required this.secondsRemaining,
    required this.status,
    required this.totalSeconds,
  });

  TimerState copyWith({
    int? secondsRemaining,
    TimerStatus? status,
    int? totalSeconds,
  }) {
    return TimerState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      status: status ?? this.status,
      totalSeconds: totalSeconds ?? this.totalSeconds,
    );
  }

  String get formattedTime {
    final minutes = (secondsRemaining / 60).floor();
    final seconds = secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progress => totalSeconds > 0 ? (totalSeconds - secondsRemaining) / totalSeconds : 0.0;
}

class StudyTimerController extends StateNotifier<TimerState> {
  Timer? _timer;

  StudyTimerController()
      : super(TimerState(
          secondsRemaining: 1500, // 25 minutes
          status: TimerStatus.idle,
          totalSeconds: 1500,
        ));

  void startTimer() {
    if (state.status == TimerStatus.running) return;

    state = state.copyWith(status: TimerStatus.running);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        stopTimer(completed: true);
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  void stopTimer({bool completed = false}) {
    _timer?.cancel();
    state = state.copyWith(
      status: completed ? TimerStatus.completed : TimerStatus.idle,
      secondsRemaining: completed ? 0 : state.totalSeconds,
    );
  }

  void resetTimer(int minutes) {
    _timer?.cancel();
    final total = minutes * 60;
    state = TimerState(
      secondsRemaining: total,
      status: TimerStatus.idle,
      totalSeconds: total,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
