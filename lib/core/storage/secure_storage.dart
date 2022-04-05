abstract class SecureStorage {
  Future<String?> read(String key);
  Future<Map<String, dynamic>> readAll();
  Future<void> deleteAll();
  Future<void> delete(String key);
  Future<void> write(String key, String value);
}
