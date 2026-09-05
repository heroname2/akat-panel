// lib/providers/dashboard_provider.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class DashboardProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  Map<String, dynamic>? _systemMetrics;
  Map<String, dynamic>? _jellyfinInfo;
  List<dynamic>? _dockerContainers;
  Map<String, dynamic>? _haStates;
  Map<String, dynamic>? _socialMediaStatus;
  Map<String, dynamic>? _aquariumData;
  List<dynamic>? _frigateCameras;

  bool _isLoading = false;
  String? _error;

  // Getters
  Map<String, dynamic>? get systemMetrics => _systemMetrics;
  Map<String, dynamic>? get jellyfinInfo => _jellyfinInfo;
  List<dynamic>? get dockerContainers => _dockerContainers;
  Map<String, dynamic>? get haStates => _haStates;
  Map<String, dynamic>? get socialMediaStatus => _socialMediaStatus;
  Map<String, dynamic>? get aquariumData => _aquariumData;
  List<dynamic>? get frigateCameras => _frigateCameras;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAllData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.wait([
        _loadSystemMetrics(),
        _loadJellyfinInfo(),
        _loadDockerContainers(),
        _loadHaStates(),
        _loadSocialMediaStatus(),
        _loadAquariumData(),
        _loadFrigateCameras(),
      ]);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadSystemMetrics() async {
    _systemMetrics = await _api.getSystemMetrics();
  }

  Future<void> _loadJellyfinInfo() async {
    _jellyfinInfo = await _api.getJellyfinSystemInfo();
  }

  Future<void> _loadDockerContainers() async {
    _dockerContainers = await _api.getDockerContainers();
  }

  Future<void> _loadHaStates() async {
    _haStates = await _api.getHaStates();
  }

  Future<void> _loadSocialMediaStatus() async {
    _socialMediaStatus = await _api.getSocialMediaStatus();
  }

  Future<void> _loadAquariumData() async {
    _aquariumData = await _api.getAquariumData();
  }

  Future<void> _loadFrigateCameras() async {
    _frigateCameras = await _api.getFrigateCameras();
  }

  Future<void> refresh() async {
    await loadAllData();
  }

  Future<bool> toggleDockerContainer(String id, String action) async {
    final result = await _api.dockerContainerAction(id, action);
    if (result) {
      await _loadDockerContainers();
      notifyListeners();
    }
    return result;
  }

  Future<bool> toggleHaEntity(String entityId) async {
    final result = await _api.toggleHaEntity(entityId);
    if (result) {
      await _loadHaStates();
      notifyListeners();
    }
    return result;
  }
}