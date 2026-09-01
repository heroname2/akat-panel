// lib/services/update_service.dart
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'path_provider_mobile.dart'
    if (dart.library.html) 'path_provider_web.dart';

class UpdateInfo {
  final String version;
  final int buildNumber;
  final String releaseNotes;
  final String downloadUrl;
  final String minVersion;
  final bool mandatory;
  final DateTime releaseDate;

  UpdateInfo({
    required this.version,
    required this.buildNumber,
    required this.releaseNotes,
    required this.downloadUrl,
    required this.minVersion,
    required this.mandatory,
    required this.releaseDate,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      version: json['version'] as String,
      buildNumber: json['buildNumber'] as int,
      releaseNotes: json['releaseNotes'] as String,
      downloadUrl: json['downloadUrl'] as String,
      minVersion: json['minVersion'] as String,
      mandatory: json['mandatory'] as bool? ?? false,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
    );
  }
}

class UpdateService {
  static const String _versionUrl = 'http://100.69.223.25:8081/version.json';
  static const String _prefsKeyLastCheck = 'last_update_check';
  static const String _prefsKeySkippedVersion = 'skipped_version';
  static const Duration _checkInterval = Duration(hours: 4);

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json'},
  ));

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    if (kIsWeb) return;

    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidInit);
    await _notifications.initialize(initSettings);

    await _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    if (kIsWeb) return;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'update_channel',
      'Uygulama Güncellemeleri',
      description: 'Yeni sürüm yayınlandığında bildirim gönderir',
      importance: Importance.high,
    );
    await _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  Future<UpdateInfo?> checkForUpdate({bool force = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final lastCheck = prefs.getInt(_prefsKeyLastCheck) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (!force && (now - lastCheck) < _checkInterval.inMilliseconds) {
      return null;
    }

    try {
      final response = await _dio.get(_versionUrl);
      if (response.statusCode == 200) {
        final updateInfo = UpdateInfo.fromJson(response.data as Map<String, dynamic>);
        
        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;
        final currentBuild = int.tryParse(packageInfo.buildNumber) ?? 0;

        if (_isNewerVersion(updateInfo.version, currentVersion) || 
            updateInfo.buildNumber > currentBuild) {
          
          final skippedVersion = prefs.getString(_prefsKeySkippedVersion);
          if (skippedVersion == updateInfo.version && !updateInfo.mandatory) {
            return null;
          }

          await prefs.setInt(_prefsKeyLastCheck, now);
          return updateInfo;
        }
      }
    } catch (e) {
      print('Güncelleme kontrolü hatası: $e');
    }

    await prefs.setInt(_prefsKeyLastCheck, now);
    return null;
  }

  bool _isNewerVersion(String remote, String local) {
    final remoteParts = remote.split('.').map(int.parse).toList();
    final localParts = local.split('.').map(int.parse).toList();
    
    for (int i = 0; i < remoteParts.length; i++) {
      final r = i < remoteParts.length ? remoteParts[i] : 0;
      final l = i < localParts.length ? localParts[i] : 0;
      if (r > l) return true;
      if (r < l) return false;
    }
    return false;
  }

  Future<void> downloadAndInstall(UpdateInfo info) async {
    if (kIsWeb) {
      await launchUrl(Uri.parse(info.downloadUrl), mode: LaunchMode.externalApplication);
      return;
    }

    final status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      final manageStatus = await Permission.manageExternalStorage.request();
      if (manageStatus.isDenied) {
        throw Exception('Depolama izni gerekli');
      }
    }

    await _showDownloadingNotification();

    try {
      final dir = await _getDownloadDirectory();
      final filePath = '${dir.path}/akat-panel-${info.version}.apk';
      final file = File(filePath);

      await _dio.download(
        info.downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = (received / total * 100).round();
            _updateDownloadNotification(progress);
          }
        },
      );

      await _showInstallNotification(filePath);
      
    } catch (e) {
      await _notifications.cancel(0);
      rethrow;
    }
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      final dir = Directory('/storage/emulated/0/Download');
      if (await dir.exists()) return dir;
    }
    final appDir = await getApplicationDocumentsDirectory();
    return appDir;
  }

  Future<void> _showDownloadingNotification() async {
    if (kIsWeb) return;

    final AndroidNotificationDetails details = AndroidNotificationDetails(
      'update_channel',
      'Uygulama Güncellemeleri',
      channelDescription: 'Yeni sürüm indiriliyor',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
      maxProgress: 100,
      progress: 0,
      onlyAlertOnce: true,
      ongoing: true,
      autoCancel: false,
    );
    await _notifications.show(0, 'AKAT PANEL', 'Güncelleme indiriliyor...', NotificationDetails(android: details));
  }

  Future<void> _updateDownloadNotification(int progress) async {
    if (kIsWeb) return;

    final AndroidNotificationDetails details = AndroidNotificationDetails(
      'update_channel',
      'Uygulama Güncellemeleri',
      channelDescription: 'Yeni sürüm indiriliyor',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
      onlyAlertOnce: true,
      ongoing: true,
      autoCancel: false,
    );
    await _notifications.show(0, 'AKAT PANEL', 'İndiriliyor... %$progress', NotificationDetails(android: details));
  }

  Future<void> _showInstallNotification(String filePath) async {
    if (kIsWeb) return;

    await _notifications.cancel(0);
    
    final AndroidNotificationDetails details = AndroidNotificationDetails(
      'update_channel',
      'Uygulama Güncellemeleri',
      channelDescription: 'Yeni sürüm indirildi',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.show(
      1,
      'AKAT PANEL',
      'Güncelleme hazır! Kurmak için dokunun.',
      NotificationDetails(android: details),
      payload: filePath,
    );
  }

  Future<void> skipVersion(String version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('skipped_version', version);
  }

  Future<UpdateInfo?> manualCheck() async {
    return checkForUpdate(force: true);
  }
}