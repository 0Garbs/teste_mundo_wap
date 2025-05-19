import 'package:connectivity_plus/connectivity_plus.dart';

import 'resource_access.dart';

class NetworkAccess implements ResourceAccess<List<ConnectivityResult>> {
  static NetworkAccess? _instance;
  final Connectivity _resource = Connectivity();
  // Avoid self instance
  NetworkAccess._();
  static NetworkAccess get i => _instance ??= NetworkAccess._();

  @override
  Future<bool> checkAccess() async {
    final connections = await _resource.checkConnectivity();

    if (connections.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connections.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connections.contains(ConnectivityResult.ethernet)) {
      return true;
    }

    return false;
  }

  @override
  Future<List<ConnectivityResult>> get() async {
    final connections = await _resource.checkConnectivity();
    return connections;
  }
}
