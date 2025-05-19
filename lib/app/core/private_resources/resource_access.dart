abstract class ResourceAccess<T> {
  Future<bool> checkAccess();

  Future<T?> get();
}
