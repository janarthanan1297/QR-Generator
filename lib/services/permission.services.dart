import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionService =
    Provider<PermissionService>((ref) => PermissionServiceImpl());

abstract class PermissionService {
  Future<bool> hasPermission(Permission permission);
  Future<bool> requestPermission(Permission permission);
  Future<Map<Permission, PermissionStatus>> requestMultiplePermission(
      List<Permission> permissions);
  Future<bool> hasCameraPermission();
  Future<bool> requestCameraPermission();
  Future<bool> requestMicPermission();
  Future<bool> hasMicPermission();
  Future<bool> hasLocationPermission();
  Future<bool> requestLocationPermission();
}

class PermissionServiceImpl extends PermissionService {
  @override
  Future<bool> hasPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    return status == PermissionStatus.granted;
  }

  @override
  Future<bool> requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    return status == PermissionStatus.granted;
  }

  @override
  Future<bool> hasCameraPermission() {
    return hasPermission(Permission.camera);
  }

  @override
  Future<bool> hasLocationPermission() {
    return hasPermission(Permission.location);
  }

  @override
  Future<bool> hasMicPermission() {
    return hasPermission(Permission.microphone);
  }

  @override
  Future<bool> requestCameraPermission() {
    return requestPermission(Permission.camera);
  }

  @override
  Future<bool> requestLocationPermission() {
    return requestPermission(Permission.location);
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestMultiplePermission(
      List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    return statuses;
  }

  @override
  Future<bool> requestMicPermission() {
    return requestPermission(Permission.microphone);
  }
}
