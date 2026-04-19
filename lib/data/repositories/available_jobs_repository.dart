import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/available_job_model.dart';
import '../services/supabase_service.dart';
import '../../features/auth/auth_controller.dart';

final availableJobsProvider =
    StateNotifierProvider<
      AvailableJobsController,
      AsyncValue<List<AvailableJobModel>>
    >((ref) {
      return AvailableJobsController(ref);
    });

final availableJobsRepositoryProvider = Provider(
  (ref) => AvailableJobsRepository(),
);

class AvailableJobsController
    extends StateNotifier<AsyncValue<List<AvailableJobModel>>> {
  final Ref _ref;

  String? _selectedRoleFilter;
  String? _selectedLocationFilter;
  WorkMode? _selectedWorkModeFilter;
  JobType? _selectedJobTypeFilter;

  AvailableJobsController(this._ref) : super(const AsyncValue.loading()) {
    loadAvailableJobs();
  }

  String? get selectedRoleFilter => _selectedRoleFilter;
  String? get selectedLocationFilter => _selectedLocationFilter;
  WorkMode? get selectedWorkModeFilter => _selectedWorkModeFilter;
  JobType? get selectedJobTypeFilter => _selectedJobTypeFilter;

  Future<void> loadAvailableJobs() async {
    print('Loading available jobs...');
    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(availableJobsRepositoryProvider);
      print(
        'Calling Himalayas API with filters - query: $_selectedRoleFilter, location: $_selectedLocationFilter',
      );

      // Fetch from Himalayas API with current filters
      final jobs = await repository.fetchFromHimalayasAPI(
        query: _selectedRoleFilter,
        location: _selectedLocationFilter,
        workMode: _selectedWorkModeFilter,
        jobType: _selectedJobTypeFilter,
      );

      print('Got ${jobs.length} jobs from API');

      // Sort by recent first
      final sortedJobs = _sortByRecent(jobs);

      state = AsyncValue.data(sortedJobs);
      print('State updated with ${sortedJobs.length} jobs');
    } catch (e, st) {
      print('Error loading jobs: $e');
      state = AsyncValue.error(e, st);
    }
  }

  List<AvailableJobModel> _sortByRecent(List<AvailableJobModel> jobs) {
    return List.from(jobs)..sort((a, b) {
      return (b.postedAt ?? DateTime(2000)).compareTo(
        a.postedAt ?? DateTime(2000),
      );
    });
  }

  void setRoleFilter(String? role) {
    _selectedRoleFilter = role;
    loadAvailableJobs(); // Reload with new API filter
  }

  void setLocationFilter(String? location) {
    _selectedLocationFilter = location;
    loadAvailableJobs(); // Reload with new API filter
  }

  void setWorkModeFilter(WorkMode? mode) {
    _selectedWorkModeFilter = mode;
    loadAvailableJobs(); // Reload with new API filter
  }

  void setJobTypeFilter(JobType? type) {
    _selectedJobTypeFilter = type;
    loadAvailableJobs(); // Reload with new API filter
  }

  void clearFilters() {
    _selectedRoleFilter = null;
    _selectedLocationFilter = null;
    _selectedWorkModeFilter = null;
    _selectedJobTypeFilter = null;
    loadAvailableJobs();
  }
}

class AvailableJobsRepository {
  static const String _himalayasBaseUrl =
      'https://himalayas.app/jobs/api/search';

  Future<List<AvailableJobModel>> fetchFromHimalayasAPI({
    String? query,
    String? location,
    WorkMode? workMode,
    JobType? jobType,
  }) async {
    try {
      final queryParams = <String, String>{'page': '1'};

      // If no query provided, use a general search term to get jobs
      final searchQuery = query ?? 'remote';
      queryParams['q'] = searchQuery;

      // Map location to country filter (Himalayas uses country codes/names)
      if (location != null && location.isNotEmpty) {
        // Try to extract country from location string
        final country = _extractCountry(location);
        if (country != null) {
          queryParams['country'] = country;
        }
      }

      // Map work mode to Himalayas filter
      if (workMode != null) {
        // Himalayas uses employment_type for this
        switch (workMode) {
          case WorkMode.remote:
            queryParams['worldwide'] = 'true';
            break;
          case WorkMode.onsite:
            queryParams['exclude_worldwide'] = 'true';
            break;
          case WorkMode.hybrid:
            // No specific filter, include all
            break;
        }
      }

      // Map job type to employment type
      if (jobType != null) {
        switch (jobType) {
          case JobType.fullTime:
            queryParams['employment_type'] = 'Full Time';
            break;
          case JobType.partTime:
            queryParams['employment_type'] = 'Part Time';
            break;
          case JobType.internship:
            queryParams['employment_type'] = 'Intern';
            break;
          case JobType.contract:
            queryParams['employment_type'] = 'Contractor';
            break;
        }
      }

      final uri = Uri.parse(
        _himalayasBaseUrl,
      ).replace(queryParameters: queryParams);

      print('Making HTTP request to: $uri');

      final response = await http
          .get(
            uri,
            headers: {
              'User-Agent': 'MeridianApp/1.0',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      print('Response status: ${response.statusCode}');
      print('Response body length: ${response.body.length}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Himalayas API returns { jobs: [...], totalCount: N, ... }
        final jobsList = data['jobs'] as List? ?? [];

        return jobsList
            .map((job) => _convertHimalayasToModel(job as Map<String, dynamic>))
            .toList();
      } else {
        // Fallback to local cache or empty
        return [];
      }
    } catch (e) {
      // Return empty list on error - could fallback to local DB
      return [];
    }
  }

  String? _extractCountry(String location) {
    // Simple country extraction - in production you'd use geocoding
    final countryMap = {
      'us': 'US',
      'usa': 'US',
      'united states': 'US',
      'uk': 'GB',
      'united kingdom': 'GB',
      'germany': 'DE',
      'france': 'FR',
      'india': 'IN',
      'canada': 'CA',
      'australia': 'AU',
      'singapore': 'SG',
      'japan': 'JP',
      'remote': 'worldwide',
    };

    final lower = location.toLowerCase();
    for (final entry in countryMap.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }

  AvailableJobModel _convertHimalayasToModel(Map<String, dynamic> job) {
    // Map Himalayas response to our AvailableJobModel
    final employmentType = job['employmentType'] as String? ?? '';
    final locationRestrictions = job['locationRestrictions'] as List? ?? [];

    WorkMode workMode;
    if (locationRestrictions.isEmpty ||
        locationRestrictions.contains('Worldwide')) {
      workMode = WorkMode.remote;
    } else {
      workMode = WorkMode.onsite;
    }

    // Determine job type from employment type
    JobType jobType;
    switch (employmentType.toLowerCase()) {
      case 'full time':
        jobType = JobType.fullTime;
        break;
      case 'part time':
        jobType = JobType.partTime;
        break;
      case 'intern':
        jobType = JobType.internship;
        break;
      case 'contractor':
      case 'temporary':
        jobType = JobType.contract;
        break;
      default:
        jobType = JobType.internship;
    }

    // Parse salary
    String? salaryRange;
    final minSalary = job['minSalary'];
    final maxSalary = job['maxSalary'];
    final currency = job['currency'] as String? ?? 'USD';
    if (minSalary != null || maxSalary != null) {
      salaryRange = '\$${minSalary ?? '?'} - \$${maxSalary ?? '?'} $currency';
    }

    // Parse posted date
    DateTime? postedAt;
    final pubDate = job['pubDate'];
    if (pubDate != null) {
      try {
        postedAt = DateTime.parse(pubDate);
      } catch (_) {}
    }

    // Extract skills from description
    List<String>? skills;
    final desc = job['description'] as String?;
    if (desc != null) {
      // Simple skill extraction - look for common tech skills
      final skillKeywords = [
        'React',
        'Node.js',
        'Python',
        'Java',
        'AWS',
        'Docker',
        'Kubernetes',
        'TypeScript',
        'JavaScript',
        'Go',
        'Rust',
        'SQL',
        'MongoDB',
      ];
      skills = skillKeywords
          .where((s) => desc.toLowerCase().contains(s.toLowerCase()))
          .toList();
    }

    return AvailableJobModel(
      id:
          job['guid'] ??
          job['id'] ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      company: job['companyName'] ?? job['company'] ?? 'Unknown Company',
      role: job['title'] ?? job['role'] ?? 'Unknown Role',
      location: locationRestrictions.isEmpty
          ? 'Remote'
          : locationRestrictions.join(', '),
      workMode: workMode,
      jobType: jobType,
      jobUrl: job['applicationLink'] ?? job['jobUrl'],
      salaryRange: salaryRange,
      description: job['description'],
      requiredSkills: skills,
      postedAt: postedAt,
      expiresAt: job['expiryDate'] != null
          ? DateTime.tryParse(job['expiryDate'])
          : null,
      isPromoted: false,
    );
  }

  // Keep local DB method as fallback
  Future<List<AvailableJobModel>> getAvailableJobs() async {
    final response = await SupabaseService.client
        .from('available_jobs')
        .select()
        .order('posted_at', ascending: false);

    return (response as List)
        .map((json) => AvailableJobModel.fromJson(_convertDbToModel(json)))
        .toList();
  }

  Map<String, dynamic> _convertDbToModel(Map<String, dynamic> dbJson) {
    return {
      'id': dbJson['id'],
      'company': dbJson['company'],
      'role': dbJson['role'],
      'location': dbJson['location'],
      'workMode': dbJson['work_mode'] ?? 'hybrid',
      'jobType': dbJson['job_type'] ?? 'internship',
      'jobUrl': dbJson['job_url'],
      'salaryRange': dbJson['salary_range'],
      'description': dbJson['description'],
      'requiredSkills': dbJson['required_skills'],
      'postedAt': dbJson['posted_at'],
      'expiresAt': dbJson['expires_at'],
      'isPromoted': dbJson['is_promoted'] ?? false,
    };
  }
}
