import 'package:flutter_test/flutter_test.dart';
import 'package:meridian/data/models/task_model.dart';
import 'package:meridian/data/models/job_model.dart';
import 'package:meridian/data/models/saved_item_model.dart';
import 'package:meridian/data/models/user_model.dart';
import 'package:meridian/data/models/briefing_model.dart';

void main() {
  group('TaskModel', () {
    test('fromJson creates valid TaskModel', () {
      final json = {
        'id': 'test-id-123',
        'user_id': 'user-456',
        'title': 'Complete DSA assignment',
        'description': 'Finish trees chapter',
        'due_at': '2024-12-31T23:59:00.000Z',
        'priority': 1,
        'status': 'in_progress',
        'course_id': 'course-789',
        'is_recurring': false,
      };

      final task = TaskModel.fromJson(json);

      expect(task.id, 'test-id-123');
      expect(task.userId, 'user-456');
      expect(task.title, 'Complete DSA assignment');
      expect(task.description, 'Finish trees chapter');
      expect(task.priority, 1);
      expect(task.status, TaskStatus.inProgress);
      expect(task.courseId, 'course-789');
    });

    test('toJson serializes correctly', () {
      const task = TaskModel(
        id: 'task-123',
        userId: 'user-456',
        title: 'Test Task',
        priority: 2,
        status: TaskStatus.todo,
      );

      final json = task.toJson();

      expect(json['id'], 'task-123');
      expect(json['user_id'], 'user-456');
      expect(json['title'], 'Test Task');
      expect(json['priority'], 2);
      expect(json['status'], 'todo');
    });

    test('TaskStatus.inProgress serializes to in_progress', () {
      const task = TaskModel(
        id: '1',
        userId: 'u',
        title: 't',
        status: TaskStatus.inProgress,
      );

      final json = task.toJson();
      expect(json['status'], 'in_progress');
    });

    test('TaskModel handles null optional fields', () {
      final json = {
        'id': 'task-123',
        'user_id': 'user-456',
        'title': 'Simple task',
      };

      final task = TaskModel.fromJson(json);

      expect(task.description, isNull);
      expect(task.dueAt, isNull);
      expect(task.courseId, isNull);
      expect(task.goalId, isNull);
      expect(task.status, TaskStatus.todo);
    });
  });

  group('JobModel', () {
    test('fromJson creates valid JobModel', () {
      final json = {
        'id': 'job-123',
        'user_id': 'user-456',
        'company': 'Google',
        'role': 'Frontend Intern',
        'location': 'Mountain View, CA',
        'status': 'applied',
        'job_url': 'https://careers.google.com/jobs/123',
        'applied_at': '2024-12-01T00:00:00.000Z',
      };

      final job = JobModel.fromJson(json);

      expect(job.id, 'job-123');
      expect(job.company, 'Google');
      expect(job.role, 'Frontend Intern');
      expect(job.status, JobStatus.applied);
      expect(job.jobUrl, 'https://careers.google.com/jobs/123');
    });

    test('JobStatus.applied serializes correctly', () {
      const job = JobModel(
        id: '1',
        userId: 'u',
        company: 'c',
        role: 'r',
        status: JobStatus.applied,
      );

      final json = job.toJson();
      expect(json['status'], 'applied');
    });

    test('JobModel handles optional fields', () {
      final json = {
        'id': 'job-123',
        'user_id': 'user-456',
        'company': 'Meta',
        'role': 'Software Engineer',
        'status': 'interview',
        'salary_range': '150000-180000',
        'notes': 'Great team',
        'next_follow_up_at': '2024-12-15T00:00:00.000Z',
      };

      final job = JobModel.fromJson(json);

      expect(job.salaryRange, '150000-180000');
      expect(job.notes, 'Great team');
      expect(job.nextFollowUpAt, isNotNull);
    });
  });

  group('SavedItemModel', () {
    test('fromJson creates valid SavedItemModel', () {
      final json = {
        'id': 'item-123',
        'user_id': 'user-456',
        'url': 'https://example.com/article',
        'title': 'Interesting Article',
        'tag': 'article',
        'ai_summary': 'A great article about algorithms',
        'ai_tags': ['algorithm', 'dsa', 'tutorial'],
      };

      final item = SavedItemModel.fromJson(json);

      expect(item.id, 'item-123');
      expect(item.url, 'https://example.com/article');
      expect(item.title, 'Interesting Article');
      expect(item.tag, SavedTag.article);
      expect(item.aiSummary, 'A great article about algorithms');
      expect(item.aiTags, ['algorithm', 'dsa', 'tutorial']);
    });

    test('SavedTag.article serializes correctly', () {
      const item = SavedItemModel(
        id: '1',
        userId: 'u',
        url: 'http://x.com',
        tag: SavedTag.article,
      );

      final json = item.toJson();
      expect(json['tag'], 'article');
    });

    test('SavedItemModel handles null AI fields', () {
      final json = {
        'id': 'item-123',
        'user_id': 'user-456',
        'url': 'https://example.com',
        'tag': 'resource',
      };

      final item = SavedItemModel.fromJson(json);

      expect(item.aiSummary, isNull);
      expect(item.aiTags, isNull);
    });
  });

  group('UserModel', () {
    test('fromJson creates valid UserModel', () {
      final json = {
        'id': 'user-123',
        'email': 'test@example.com',
        'name': 'John Doe',
        'college': 'MIT',
        'year': 3,
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'user-123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'John Doe');
      expect(user.college, 'MIT');
      expect(user.year, 3);
    });

    test('UserModel handles null optional fields', () {
      final json = {'id': 'user-123', 'email': 'test@example.com'};

      final user = UserModel.fromJson(json);

      expect(user.name, isNull);
      expect(user.college, isNull);
      expect(user.year, isNull);
    });
  });

  group('BriefingModel', () {
    test('fromJson creates valid BriefingModel', () {
      final json = {
        'id': 'briefing-123',
        'user_id': 'user-456',
        'date': '2024-12-15T00:00:00.000Z',
        'content_json': {
          'insight': 'Great progress on DSA!',
          'highlighted_tasks': [
            {'title': 'Complete Binary Tree', 'priority': 1},
          ],
        },
      };

      final briefing = BriefingModel.fromJson(json);

      expect(briefing.id, 'briefing-123');
      expect(briefing.date, isA<DateTime>());
      expect(briefing.contentJson['insight'], 'Great progress on DSA!');
    });
  });
}
