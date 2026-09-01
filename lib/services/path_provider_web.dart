// lib/path_provider_web.dart
import 'dart:io';

Future<Directory> getApplicationDocumentsDirectory() async {
  // Web'de bu fonksiyon kullanılamaz, fallback olarak geçici dizin döndür
  return Directory.systemTemp;
}