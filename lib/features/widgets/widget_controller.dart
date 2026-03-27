import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../tasks/tasks_controller.dart';
import '../../data/models/task_model.dart';
import 'dart:convert';

final widgetControllerProvider = Provider((ref) {
  return WidgetController(ref);
});

class WidgetController {
  final Ref _ref;

  WidgetController(this._ref) {
    _init();
  }

  Future<void> _init() async {
    await HomeWidget.setAppGroupId('group.meridian.widget');
  }

  Future<void> updateWidgets() async {
    // 1. Fetch tasks
    final tasksAsync = _ref.read(tasksProvider);
    
    tasksAsync.whenData((tasks) async {
      final activeTasks = tasks.where((t) => t.status != TaskStatus.done).toList();
      activeTasks.sort((a, b) => a.priority.compareTo(b.priority));
      
      final topTasks = activeTasks.take(3).toList();
      
      // 2. Format for widget
      final List<Map<String, dynamic>> widgetData = topTasks.map((t) => {
        'title': t.title,
        'priority': t.priority,
      }).toList();

      // 3. Send to platform
      await HomeWidget.saveWidgetData<String>('top_tasks', jsonEncode(widgetData));
      
      // 4. Trigger update
      await HomeWidget.updateWidget(
        name: 'TaskWidgetProvider', // iOS
        androidName: 'TaskWidgetProvider', // Android class name
      );
    });
  }
}
