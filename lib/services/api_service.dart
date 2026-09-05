// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Base URLs - Tailscale IP'ler
  static const String _baseUrl = 'http://100.69.223.25';
  static const String _jellyfinUrl = '$_baseUrl:8096';
  static const String _homeAssistantUrl = '$_baseUrl:8123';
  static const String _socialMediaUrl = '$_baseUrl:5000'; // Flask API port
  static const String _aquariumUrl = '$_baseUrl:5001';    // Aquarium Flask port
  static const String _frigateUrl = '$_baseUrl:5002';     // Frigate port
  static const String _dockerUrl = 'http://localhost:2375'; // Docker socket proxy
  static const String _metricsUrl = '$_baseUrl:8082';      // Metrics server

  // Tokens (SharedPreferences'tan yüklenecek)
  String? _jellyfinToken;
  String? _homeAssistantToken;

  Future<void> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _jellyfinToken = prefs.getString('jellyfin_token');
    _homeAssistantToken = prefs.getString('homeassistant_token');
  }

  // Generic GET request
  Future<Map<String, dynamic>?> _get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('API GET Error: ${response.statusCode} - $url');
        return null;
      }
    } catch (e) {
      print('API GET Exception: $e');
      return null;
    }
  }

  // Generic POST request
  Future<Map<String, dynamic>?> _post(String url, {Map<String, String>? headers, Object? body}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', ...?headers},
        body: body != null ? json.encode(body) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        print('API POST Error: ${response.statusCode} - $url');
        return null;
      }
    } catch (e) {
      print('API POST Exception: $e');
      return null;
    }
  }

  // ==================== JELLYFIN API ====================
  Future<Map<String, dynamic>?> getJellyfinSystemInfo() async {
    return _get('$_jellyfinUrl/System/Info', headers: {'X-Emby-Token': _jellyfinToken ?? ''});
  }

  Future<List<dynamic>?> getJellyfinLibraries() async {
    return _get('$_jellyfinUrl/Libraries', headers: {'X-Emby-Token': _jellyfinToken ?? ''}) as Future<List<dynamic>?>;
  }

  Future<List<dynamic>?> getJellyfinItems({
    String? parentId,
    String? userId,
    bool? isPlayed,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (parentId != null) queryParams['ParentId'] = parentId;
    if (userId != null) queryParams['UserId'] = userId;
    if (isPlayed != null) queryParams['Filters'] = isPlayed ? 'IsPlayed' : 'IsUnplayed';
    if (limit != null) queryParams['Limit'] = limit.toString();
    queryParams['Recursive'] = 'true';
    queryParams['Fields'] = 'BasicSyncInfo,CanDelete,MediaSourceCount,ParentId,Path,Overview,Genres,SortName,OfficialRating,CommunityRating,RunTimeTicks,PremiereDate,ProductionYear,IndexNumber,ParentIndexNumber,SeasonName,SeriesName,Type';

    final uri = Uri.parse('$_jellyfinUrl/Items').replace(queryParameters: queryParams);
    return _get(uri.toString(), headers: {'X-Emby-Token': _jellyfinToken ?? ''}) as Future<List<dynamic>?>;
  }

  Future<bool> markJellyfinPlayed(String itemId, String userId, bool played) async {
    final result = await _post(
      '$_jellyfinUrl/Users/$userId/PlayedItems/$itemId',
      headers: {'X-Emby-Token': _jellyfinToken ?? ''},
    );
    return result != null;
  }

  // ==================== HOME ASSISTANT API ====================
  Future<Map<String, dynamic>?> getHaStates() async {
    return _get('$_homeAssistantUrl/api/states', headers: {'Authorization': 'Bearer $_homeAssistantToken'});
  }

  Future<Map<String, dynamic>?> getHaEntity(String entityId) async {
    return _get('$_homeAssistantUrl/api/states/$entityId', headers: {'Authorization': 'Bearer $_homeAssistantToken'});
  }

  Future<bool> callHaService(String domain, String service, {Map<String, dynamic>? data, String? targetEntity}) async {
    final body = data ?? {};
    if (targetEntity != null) {
      body['entity_id'] = targetEntity;
    }
    final result = await _post(
      '$_homeAssistantUrl/api/services/$domain/$service',
      headers: {'Authorization': 'Bearer $_homeAssistantToken'},
      body: body,
    );
    return result != null;
  }

  Future<bool> toggleHaEntity(String entityId) async {
    final state = await getHaEntity(entityId);
    if (state == null) return false;
    final domain = entityId.split('.').first;
    final currentState = state['state'];
    final service = currentState == 'on' ? 'turn_off' : 'turn_on';
    return callHaService(domain, service, targetEntity: entityId);
  }

  // ==================== DOCKER API (via socket proxy) ====================
  Future<List<dynamic>?> getDockerContainers({bool all = true}) async {
    final uri = Uri.parse('$_dockerUrl/containers/json').replace(queryParameters: {'all': all.toString()});
    return _get(uri.toString()) as Future<List<dynamic>?>;
  }

  Future<bool> dockerContainerAction(String id, String action) async {
    final result = await _post('$_dockerUrl/containers/$id/$action');
    return result != null;
  }

  Future<String?> getDockerContainerLogs(String id, {int tail = 100}) async {
    final uri = Uri.parse('$_dockerUrl/containers/$id/logs').replace(queryParameters: {'stdout': 'true', 'stderr': 'true', 'tail': tail.toString()});
    try {
      final response = await http.get(uri);
      return response.body;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getDockerSystemInfo() async {
    return _get('$_dockerUrl/info');
  }

  // ==================== SOCIAL MEDIA BOT API ====================
  Future<Map<String, dynamic>?> getSocialMediaStatus() async {
    return _get('$_socialMediaUrl/api/status');
  }

  Future<List<dynamic>?> getSocialMediaSchedule() async {
    return _get('$_socialMediaUrl/api/schedule') as Future<List<dynamic>?>;
  }

  Future<List<dynamic>?> getSocialMediaQueue({String? platform}) async {
    final queryParams = <String, String>{};
    if (platform != null) queryParams['platform'] = platform;
    final uri = Uri.parse('$_socialMediaUrl/api/queue').replace(queryParameters: queryParams);
    return _get(uri.toString()) as Future<List<dynamic>?>;
  }

  Future<bool> triggerSocialMediaUpload(String videoId, String platform) async {
    final result = await _post('$_socialMediaUrl/api/upload', body: {'video_id': videoId, 'platform': platform});
    return result != null;
  }

  // ==================== AQUARIUM API ====================
  Future<Map<String, dynamic>?> getAquariumData() async {
    return _get('$_aquariumUrl/api/data');
  }

  Future<List<dynamic>?> getAquariumHistory({String? sensor, int? hours}) async {
    final queryParams = <String, String>{};
    if (sensor != null) queryParams['sensor'] = sensor;
    if (hours != null) queryParams['hours'] = hours.toString();
    final uri = Uri.parse('$_aquariumUrl/api/history').replace(queryParameters: queryParams);
    return _get(uri.toString()) as Future<List<dynamic>?>;
  }

  Future<bool> addAquariumFeeding(String foodType, double amount) async {
    final result = await _post('$_aquariumUrl/api/feeding', body: {'food_type': foodType, 'amount': amount});
    return result != null;
  }

  // ==================== FRIGATE / CAMERA API ====================
  Future<List<dynamic>?> getFrigateCameras() async {
    return _get('$_frigateUrl/api/cameras') as Future<List<dynamic>?>;
  }

  Future<Map<String, dynamic>?> getFrigateEvents({int? limit, String? camera}) async {
    final queryParams = <String, String>{};
    if (limit != null) queryParams['limit'] = limit.toString();
    if (camera != null) queryParams['camera'] = camera;
    final uri = Uri.parse('$_frigateUrl/api/events').replace(queryParameters: queryParams);
    return _get(uri.toString());
  }

  String getCameraStreamUrl(String cameraName) {
    // Frigate RTSP/Go2RTC proxy URL
    return '$_frigateUrl/api/cameras/$cameraName/stream.mp4';
  }

  String getCameraSnapshotUrl(String cameraName) {
    return '$_frigateUrl/api/cameras/$cameraName/snapshot.jpg';
  }

  // ==================== SYSTEM METRICS ====================
  Future<Map<String, dynamic>?> getSystemMetrics() async {
    return _get('$_metricsUrl/metrics');
  }

  // ==================== TOKEN MANAGEMENT ====================
  Future<void> saveJellyfinToken(String token) async {
    _jellyfinToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jellyfin_token', token);
  }

  Future<void> saveHomeAssistantToken(String token) async {
    _homeAssistantToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('homeassistant_token', token);
  }

  Future<void> clearTokens() async {
    _jellyfinToken = null;
    _homeAssistantToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jellyfin_token');
    await prefs.remove('homeassistant_token');
  }
}