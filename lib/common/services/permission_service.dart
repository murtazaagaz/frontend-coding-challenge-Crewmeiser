import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermission() async {
    if (kIsWeb) {
      return true; // Web doesn't need storage permission
    }

    if (await Permission.storage.isGranted) {
      return true;
    }

    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  static Future<bool> requestDownloadsPermission() async {
    if (kIsWeb) {
      return true; // Web doesn't need downloads permission
    }

    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }

    if (Platform.isIOS) {
      if (await Permission.photos.isGranted) {
        return true;
      }

      final status = await Permission.photos.request();
      return status.isGranted;
    }

    return true; // For other platforms, assume permission is granted
  }

  static Future<bool> hasRequiredPermissions() async {
    if (kIsWeb) {
      return true; // Web doesn't need permissions
    }

    if (Platform.isAndroid) {
      final storagePermission = await Permission.storage.isGranted;
      final downloadsPermission = await Permission.accessMediaLocation.isGranted;
      return storagePermission && downloadsPermission;
    }

    if (Platform.isIOS) {
      final photosPermission = await Permission.photos.isGranted;
      return photosPermission;
    }

    return true; // For other platforms, assume permissions are granted
  }
}
