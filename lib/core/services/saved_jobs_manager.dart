import 'package:flutter/foundation.dart';

class SavedJobItem {
  final String title;
  final String location;
  final String matchPercentage;
  final List<String> tags;
  final String companyInitial;

  SavedJobItem({
    required this.title,
    required this.location,
    required this.matchPercentage,
    required this.tags,
    required this.companyInitial,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedJobItem && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}

class SavedJobsManager extends ChangeNotifier {
  static final SavedJobsManager _instance = SavedJobsManager._internal();
  factory SavedJobsManager() => _instance;
  SavedJobsManager._internal();

  final List<SavedJobItem> _savedJobs = [
    SavedJobItem(
      title: 'Flutter Developer - Remote',
      location: 'عن بعد - مصر',
      matchPercentage: 'توافق 87%',
      tags: ['Flutter', 'عن بعد'],
      companyInitial: 'T',
    ),
    SavedJobItem(
      title: 'Mobile App Developer',
      location: 'عبدالعزيز - القاهرة',
      matchPercentage: 'توافق 76%',
      tags: ['Flutter', 'عن بعد'],
      companyInitial: 'V',
    ),
  ];

  List<SavedJobItem> get savedJobs => List.unmodifiable(_savedJobs);

  bool isSaved(String title) {
    return _savedJobs.any((job) => job.title == title);
  }

  void toggleSave({
    required String title,
    required String location,
    required String matchPercentage,
    required List<String> tags,
    required String companyInitial,
  }) {
    final item = SavedJobItem(
      title: title,
      location: location,
      matchPercentage: matchPercentage,
      tags: tags,
      companyInitial: companyInitial,
    );

    final index = _savedJobs.indexWhere((j) => j.title == title);
    if (index >= 0) {
      _savedJobs.removeAt(index);
    } else {
      _savedJobs.add(item);
    }
    notifyListeners();
  }
}
