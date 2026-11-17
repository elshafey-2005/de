import 'package:flutter/material.dart';

class CvState extends ChangeNotifier {
  static final CvState _instance = CvState._internal();
  factory CvState() => _instance;
  CvState._internal();

  bool _isUploaded = false;
  String _fileName = 'Khaled_Abdelaziz_CV.pdf';

  bool get isUploaded => _isUploaded;
  String get fileName => _fileName;

  void markCvUploaded({String? fileName}) {
    _isUploaded = true;
    if (fileName != null && fileName.isNotEmpty) {
      _fileName = fileName;
    }
    notifyListeners();
  }

  void resetCv() {
    _isUploaded = false;
    notifyListeners();
  }
}
